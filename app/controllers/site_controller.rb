class SiteController < ApplicationController
  skip_before_filter :authenticate, :only => [:welcome, :access_denied]
  
  def welcome
    respond_to do |format|
      format.html { render 'welcome', layout: 'site' }
    end
  end

  def access_denied
  end
end
