class StadiumsController < ApplicationController

  def index
    @stadiums = Stadium.all.order(:created_at)
  end


  def new
    @stadium = Stadium.new
  end

  def create
    @stadium = Stadium.new(stadium_params)
    if @stadium.save
      redirect_to stadiums_path
    else
      render :new
    end
  end

  def edit
    @stadium = Stadium.find(params[:id])
  end

  def update
    @stadium = Stadium.find(params[:id])
    if @stadium.update(stadium_params)
      redirect_to stadiums_path
    else
      render :edit
    end
  end



  private
  def stadium_params
    params.require(:stadium).permit(:name, :address, :kind)
  end



end
