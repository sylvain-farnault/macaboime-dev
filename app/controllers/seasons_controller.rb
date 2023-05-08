class SeasonsController < ApplicationController

  def index
    @seasons = Season.all.order(years: :desc)
    @season = Season.new
  end

  def create
    @season = Season.new(season_params)
    if @season.save
      redirect_to seasons_path
    end
  end

  def show
    @season = Season.find_by_years(params[:id])
  end

  def destroy
    @season = Season.find_by_years(params[:id])
    if @season
      @season.destroy
      redirect_to seasons_path
    end
  end

  def stats_stabis
    @season = Season.find_by_years(params[:id])
    @edition = @season.editions.find{|e| e.competition.kind == "championship"}
    @teams = @edition.teams
    @schedules = @edition.schedules
  end

  private

  def season_params
    params.require(:season).permit(:years)
  end
end
