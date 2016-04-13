class SiteController < ApplicationController
  skip_before_filter :authenticate, :only => [:welcome, :access_denied, :status]
  skip_before_filter :require_login, :only => [:welcome, :access_denied, :auth, :status]

  def show_checklist
    # Type casted to int to prevent malicious intent for params :id
    checklist_num = params[:id].to_i
    
    url = "/#/checklists/" + checklist_num.to_s
    redirect_to url
  end

  def archive_checklist
    # Type casted to int to prevent malicious intent for params :id
    checklist_num = params[:id].to_i

    # Archive checklist
    checklist = Checklist.where(:id => checklist_num).take
    checklist.archived = true
    checklist.save

    # Redirect to checklist
    url = "/#/checklists/" + checklist_num.to_s
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
