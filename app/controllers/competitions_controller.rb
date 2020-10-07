class CompetitionsController < ApplicationController

  def index
    @competitions = Competition.all
    @competition = Competition.new
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def create
    @competition = Competition.new(competition_params)
    if @competition.save
      redirect_to competitions_path
    end
  end

  def destroy
    @competition = Competition.find(params[:id])
    if @competition
      @competition.destroy
      redirect_to competitions_path
    end
  end

  def display_championship_calendar(edition)

  end

  private

  def competition_params
    params.require(:competition).permit(:name, :kind)
  end

end
