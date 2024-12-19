class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_seasons, :set_teams

  private

  def set_seasons
    @seasons = Season.where(id: Edition.pluck(:season_id).uniq).order(years: :desc)
  end

  def set_teams
    @teams = Team.all.sort_by{|t| t.name}
  end
end
