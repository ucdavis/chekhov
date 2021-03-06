class AnalyticsController < ApplicationController
  respond_to :json
  filter_resource_access

  def index
    if params[:start] and params[:end]
        start_date = Date.parse(params[:start]).in_time_zone
        # Using .next_day to include all of end date (i.e., up to 23:59:59)
        end_date = Date.parse(params[:end]).next_day.in_time_zone
        @checklists = Checklist.where("
            (started >= :start_date AND started <= :end_date)
            OR (finished >= :start_date AND finished <= :end_date)",
          {
            start_date: start_date,
            end_date: end_date
          }
        ).select('user_id, started, finished, ticket_number')

        @visits = Visit.where("created_at >= :start_date AND created_at <= :end_date",
            {
              start_date: start_date,
              end_date: end_date
            }).group("date(created_at)").count
    else
        @checklists = Checklist.select('user_id, started, finished, ticket_number')
        @visits = Visit.group("date(created_at)").count
    end


    respond_with(@checklists) do |format|
        format.json
    end
  end
end
