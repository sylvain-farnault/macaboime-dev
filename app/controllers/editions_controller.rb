class EditionsController < ApplicationController

  def index
    @editions = Edition.all.order(:season_id, :competition_id)
    @edition = Edition.new
  end

  def create
    @edition = Edition.new(edition_params)
    if @edition.save
      redirect_to editions_path
    end
  end

  def show
    @edition = Edition.find(params[:id])
  end

  private

  def edition_params
    params.require(:edition).permit(:season_id, :competition_id)
  end
end
