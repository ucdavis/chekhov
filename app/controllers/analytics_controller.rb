class AnalyticsController < ApplicationController
  respond_to :json
  filter_access_to :all, :attribute_check => true

  def index
    
  end
