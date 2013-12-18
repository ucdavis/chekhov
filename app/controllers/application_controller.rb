class ApplicationController < ActionController::Base
  include Authentication
  before_action :authenticate
  
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
end
