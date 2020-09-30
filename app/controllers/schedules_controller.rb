class SchedulesController < ApplicationController
  def index
    @edition = Edition.find(params[:edition_id])
    @schedules = Schedule.where(edition: params[:edition_id])

  end
end
