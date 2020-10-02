class PagesController < ApplicationController
  def home
    current_year = Time.now.year
    start_year =
      (Time.now > Time.new(current_year,8,15)) ?
      current_year : (current_year - 1)
    season_years = start_year.to_s + "-" + (start_year + 1).to_s
    season = Season.where(years: season_years)
    competition = Competition.where(kind: "championship")
    @current_championship_edition = Edition.where(season: season, competition: competition)
    raise
  end

  def power

  end
end
