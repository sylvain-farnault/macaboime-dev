class TeamsController < ApplicationController

  def index
    @teams = Team.all
    @new_team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team_name = TeamName.new(team_name_params)
    if @team.save
      @team_name.team = @team
      if @team_name.save
        redirect_to teams_path
      end
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:description, :resiednt)
  end

  def team_name_params
    params.require(:team).permit(:name, :used_since)
  end
end
