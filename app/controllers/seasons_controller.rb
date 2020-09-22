class SeasonsController < ApplicationController

  def index
    @season = Season.new
    @seasons = Season.all.order(years: :desc)

  end

  def create
    @season = Season.new(season_params)
    if @season.save
      redirect_to seasons_path
    end
  end

  def show
    @season = Season.find(params[:id])
    # Get all competitions for a @season

  end

  def destroy
    @season = Season.find(params[:id])
    if @season
      @season.destroy
      redirect_to seasons_path
    end

  end

  private

  def season_params
    params.require(:season).permit(:years)
  end
end
