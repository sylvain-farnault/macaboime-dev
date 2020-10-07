class PagesController < ApplicationController
  def home
    # GET current championship edition instance that need to be send to the partial
    # See later the possibility to get season_years into path macaboime.fr/2020-2021
    current_year = Time.now.year
    start_year =
      (Time.now > Time.new(current_year,8,15)) ?
      current_year : (current_year - 1)
    season_years = start_year.to_s + "-" + (start_year + 1).to_s
    season = Season.where(years: season_years)
    competition = Competition.where(kind: "championship")
    @current_championship_edition = Edition.find_by(season: season, competition: competition)
  end

  def power

  end
end
