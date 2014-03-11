class SiteController < ApplicationController
  skip_before_filter :authenticate, :only => [:welcome, :access_denied]
  skip_before_filter :require_login, :only => [:welcome, :access_denied, :auth]
  
  def welcome
    respond_to do |format|
      format.html { render 'welcome', layout: 'site' }
    end
  end

  def access_denied
  end

  def auth
    req = params['req'].blank? ? templates_url : params['req']
    redirect_to req
  end
end
