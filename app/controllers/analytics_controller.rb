class AnalyticsController < ApplicationController
  respond_to :json
#  filter_access_to :all, :attribute_check => true

  def index
    if params[:start] and params[:end]
        @checklists = Checklist.where("
            (started >= :start_date AND started <= :end_date)
            OR (finished >= :start_date AND finished <= :end_date)",
          {
            start_date: Date.parse(params[:start]),
            end_date: Date.parse(params[:end])
          }
        ).select('user_id, started, finished, ticket_number')
    else
        @checklists = Checklist.select('user_id, started, finished, ticket_number')
    end

    respond_with(@checklists) do |format|
        format.json
    end
  end
end
