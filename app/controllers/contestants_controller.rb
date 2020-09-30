class ContestantsController < ApplicationController
  def index
    # raise
    @contestants = Contestant.where(edition: params[:edition_id])
    @edition = Edition.find(params[:edition_id])
    @new_contestant = Contestant.new
  end

  def create
    @edition = Edition.find(params[:edition_id])
    @contestant = Contestant.new(contestant_params)
    @contestant.edition = @edition
    if @contestant.save
      redirect_to edition_contestants_path(@edition)
    end

  end

  private

  def contestant_params
    params.require(:contestant).permit(:team_id)
  end
end
