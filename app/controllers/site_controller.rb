class SiteController < ApplicationController
  skip_before_filter :authenticate, :only => [:welcome, :access_denied, :status]
  skip_before_filter :require_login, :only => [:welcome, :access_denied, :auth, :status]

  def show_checklist
    checklist_num = params[:id]
    url = "/#/checklists/" + checklist_num
    redirect_to url
  end

  def archive_checklist
    # Archive checklist
    checklist = Checklist.where(:id => params[:id]).take
    checklist.archived = true
    checklist.save

    # Redirect to checklist
    url = "/#/checklists/" + params[:id]
    redirect_to url
  end


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
