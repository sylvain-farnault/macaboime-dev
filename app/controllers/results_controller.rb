class ResultsController < ApplicationController
  def enter_results
    current_year = Time.now.year
    start_year =
      (Time.now > Time.new(current_year,8,15)) ?
      current_year : (current_year - 1)
    season_years = start_year.to_s + "-" + (start_year + 1).to_s
    season = Season.where(years: season_years)
    edition = Edition.where(season: season)
    @schedule = Schedule.where(edition: edition).where("day < ?", Time.now).last
  end

  def update_results
    @schedule = Schedule.find(params[:schedule_id])
    if @schedule.update(schedule_params)
      redirect_to enter_results_path
    end
  end

  private

   def schedule_params
      params.require(:schedule).permit(games_attributes: [:id, :status, results_attributes: [:id, :mark, :points_award, :forfeit]])
   end
end
