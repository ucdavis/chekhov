module Authentication
  # Returns the current_user, which may be 'false' if impersonation is active
  def current_user
    if impersonating?
      return Authorization.current_user
    else
      case session[:auth_via]
      when :cas
        return Authorization.current_user
      end
    end
  end

  # Returns the 'actual' user - usually this matches current_user but when
  # impersonating, it will return the human doing the impersonating, not the
  # account they are pretending to be. Useful for determining if actions like
  # 'un-impersonate' should be made available.
  def actual_user
    User.find_by_id(session[:user_id])
  end

  # Ensure session[:auth_via] exists.
  # This is populated by a whitelisted IP request, a CAS redirect or a HTTP Auth request
  def authenticate
    if session[:auth_via]
      case session[:auth_via]
      when :cas
        if impersonating?
          Authorization.current_user = User.find_by_id(session[:impersonation_id])
        else
          Authorization.current_user = User.find_by_id(session[:user_id])
        end
      end
      logger.info "User authentication passed due to existing session: #{session[:auth_via]}, #{session[:user_id]}, #{Authorization.current_user}"
      return
    end

    # It's important we do this before checking session[:cas_user] as it
    # sets that variable. Note that the way before_filters work, this call
    # will render or redirect but this function will still finish before
    # the redirect is actually made.
    CASClient::Frameworks::Rails::Filter.filter(self)

    if session[:cas_user]
      @user = User.find_or_initialize_by_loginid(session[:cas_user])

      if @user.new_record?
        rm_json = RolesManagement.fetch_json_by_loginid(@user.loginid)
        if rm_json
          @user.rm_id = rm_json["id"]
          @user.name = rm_json["name"]
          @user.email = rm_json["email"]

          Authorization.ignore_access_control(true)

          @user.save!

          Authorization.ignore_access_control(false)
        else
          session[:user_id] = nil
          session[:auth_via] = nil
          Authorization.current_user = nil

          logger.warn "CAS user is valid but could not be found in Roles Management."

          redirect_to access_denied_path
          return
        end
      end

      # Valid user found through CAS.
      session[:user_id] = @user.id
      session[:auth_via] = :cas
      Authorization.current_user = @user

      logger.info "Valid CAS user. Passes authentication."
    end
  end

  # Returns true if we're currently impersonating another user
  def impersonating?
    session[:impersonation_id] ? true : false
  end
end
