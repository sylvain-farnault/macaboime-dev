class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :season_show]
  before_action :datas_for_season, only: [:home, :season_show]

  def home
    @teams = Team.all
  end

  def power
    redirect_to enter_results_path if current_user.referee?
  end

  def season_show
  end

  private

  def datas_for_season
    # GET current championship edition instance that need to be send to the partial
    # See later the possibility to get season_years into path macaboime.fr/2020-2021

    season_years = params[:season_years] || SeasonsHelper::CurrentSeasonYears.get
    season = Season.find_by(years: season_years)
    competition = Competition.where(kind: "championship")
    @edition = Edition.find_by(season: season, competition: competition)
    @articles = season.articles.order(id: :desc) if season

    @ranking_datas = Competitions::Championship.new(edition: @edition).ranking_datas

    # select all schedules (all competition kinds) from the same season of that @schedule
    @season_schedules = Schedule.where(edition_id: Edition.where(season: @edition.season)).order(:id) if @edition
  end
end
