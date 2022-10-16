class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_seasons

  private

  def set_seasons
    @seasons = Season.where(id: Edition.pluck(:season_id).uniq).order(years: :desc)
  end
end
