class SchedulesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  respond_to :html, :js

  def index
    @edition = Edition.find(params[:edition_id])
    @schedules = Schedule.where(edition: params[:edition_id])
    @schedule = Schedule.new
  end

  def show
    @schedule = Schedule.find(params[:id])
    respond_to do |format|
      format.js {render layout: false}
      format.html
    end
  end

  def create
    @edition = Edition.find(params[:edition_id])
    # Recieve first schedule date from the form
    @schedule = Schedule.new(schedule_params)

    # initialise round number
    i = 1

    current_date = (Time.now + Time.now.utc_offset).utc
    # if first day schedule (send through form) is in the futur
    if (@schedule.day > current_date)
      # then save 1st schedule
      @schedule.designation = "J" + sprintf("%02d",i)
      @schedule.edition = @edition
      if @schedule.save
        i += 1
        # then create next ones (date + 7 days) btw 2 schedules
        while i <= ((@edition.teams.count - 1 + (@edition.teams.count % 2)) * 2)
          # create new schedule 7 days later
          Schedule.create(
            edition: @edition,
            day: Schedule.all.last.day + 7,
            designation: "J" + sprintf("%02d",i))
          # increment round number
          i += 1
        end
        redirect_to edition_schedules_path(@edition)
      end
    end
  end

  def generate_games
    @edition = Edition.find(params[:edition_id])

    # Generate a RoundRobin for @edition.teams
    first_legs_games = RoundRobinTournament.schedule(@edition.teams.shuffle)

    schedule = @edition.schedules.order(:created_at).first
    first_legs_games.each do |day|
      day.each do |game|
        if game.compact.count == 2
          new_game = Game.create(schedule: schedule)
          Result.create(game: new_game, team: game.first)
          Result.create(game: new_game, team: game.last)
        end
      end
      schedule = schedule.next
    end
    second_legs_games = first_legs_games.shuffle
    second_legs_games.each do |day|
      day.each do |game|
        if game.compact.count == 2
          new_game = Game.create(schedule: schedule)
          Result.create(game: new_game, team: game.last)
          Result.create(game: new_game, team: game.first)
        end
      end
      schedule = schedule.next
    end

  end

  private

  def schedule_params
    params.require(:schedule).permit(:day)
  end
end
