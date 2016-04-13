class SiteController < ApplicationController
  skip_before_filter :authenticate, :only => [:welcome, :access_denied, :status]
  skip_before_filter :require_login, :only => [:welcome, :access_denied, :auth, :status]

  def access_denied
  end

  def auth
    req = params['req'].blank? ? templates_url : params['req']
    redirect_to req
  end

  def status
      @number_of_checklists = Checklist.all.count

      respond_to do |format|
          format.json { render :json => {checklist_count: @number_of_checklists, Status: "OK"}}
      end
  end

end
