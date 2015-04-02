class ApplicationController < ActionController::Base
  include Authentication
  before_filter :require_login
  before_action :authenticate
  after_action  :track_visits
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def permission_denied
    if request.format.to_s.include? 'json'
      # JSON request
      render :json => "Permission denied.", :status => 403
    elsif session[:auth_via] == :cas
      # Non-JSON, human-facing error
      flash[:error] = "Sorry, you are not allowed to access that page."
      redirect_to access_denied_path
    else
      # Non-JSON, machine-facing error
      render :text => "Permission denied.", :status => 403
    end
  end

  private

  def track_visits
    if logged_in? && defined? Authorization.current_user[]
        user = User.find(Authorization.current_user[:id]).id

        # For reference, reverse operation of IPAddr to_i is:
        # IPAddr.new(167772687, Socket::AF_INET).to_s
        ip = IPAddr.new request.remote_ip

        date = Date.today
        previous_visit = Visit.where(user_id: user, created_at: (Time.now.midnight..(Time.now.midnight + 1.day))).exists?

        if ! previous_visit
            visit = Visit.create :user_id => user,
                                 :session_id => request.session_options[:id],
                                 :ip_address => ip.to_s,
                                 :user_agent => request.env["HTTP_USER_AGENT"]
        end
    end
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to auth_url({req: request.original_url}) # halts request cycle
    end
  end

  # The logged_in? method simply returns true if the user is logged
  # in and false otherwise. It does this by "booleanizing" the
  # current_user method we created previously using a double ! operator.
  # Note that this is not common in Ruby and is discouraged unless you
  # really mean to convert something into true or false.
  def logged_in?
    !!current_user
  end
end
