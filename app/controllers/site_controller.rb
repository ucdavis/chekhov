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
    redirect_to params['req']
  end
end
