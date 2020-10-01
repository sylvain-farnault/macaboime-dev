class SchedulesController < ApplicationController
  def index
    @edition = Edition.find(params[:edition_id])
    @schedules = Schedule.where(edition: params[:edition_id])
    @schedule = Schedule.new
  end

  def create
    @edition = Edition.find(params[:edition_id])
    # Recieve first schedule date from the form
    @schedule = Schedule.new(schedule_params)

    # initialise round number
    i = 1

    current_date = (Time.now + Time.now.utc_offset).utc
    # if first day schedule (send through form) is in the futur
    if (@schedule.day > current_date)
      # then save 1st schedule
      @schedule.designation = "J" + sprintf("%02d",i)
      @schedule.edition = @edition
      if @schedule.save
        i +=1
        # then create next ones (date + 7 days) btw 2 schedules
        while i <= @edition.total_rounds
          # create new schedule 7 days later
          Schedule.create(
            edition: @edition,
            day: Schedule.all.last.day + 7,
            designation: "J" + sprintf("%02d",i))
          # increment round number
          i +=1
        end
        redirect_to edition_schedules_path(@edition)
      end
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:day)
  end
end
