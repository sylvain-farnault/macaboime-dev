class ResultsController < ApplicationController
  def enter_results
    if params.has_key?(:id)
      @schedule = Schedule.find(params[:id])
    else
      current_year = Time.now.year
      #
      start_year =
        (Time.now > Time.new(current_year,8,15)) ?
        current_year : (current_year - 1)
      # define current season years (ex: 2020-2021)
      season_years = start_year.to_s + "-" + (start_year + 1).to_s
      # I use it to find the corresponding season instance
      season = Season.where(years: season_years)
      # And then corresponding edition
      # ### WARNING
      # I may have up to 3 editions (for friendly, championship and cup)
      edition = Edition.where(season: season)
      # raise
      @schedule = Schedule.where(edition: edition).where("day < ?", Time.now).last
    end
    @season_schedules = Schedule.where(edition_id: Edition.where(season: @schedule.edition.season))
  end

  def update_results
    @schedule = Schedule.find(params[:schedule_id])
    if @schedule.update(schedule_params)
      redirect_to enter_results_path(@schedule),
      notice: "Schedule #{@schedule.designation} has been updated!"
    end
  end

  private

   def schedule_params
      params.require(:schedule).permit(:id, :day, :designation, games_attributes: [:id, :status, :stadium_id, :alternative_date, results_attributes: [:id, :mark, :penalty_mark, :points_award, :forfeit]])
   end
end
