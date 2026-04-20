class SchedulesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :calendar_per_week]
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

  def calendar_per_week
    Rails.logger.info params
    week = params[:week].to_i
    year = params[:year].to_i
    # On retrouve la Season courrante
    season = week < 30 ? Season.find_by_years("#{year - 1}-#{year}"): Season.find_by_years("#{year}-#{year + 1}")
    schedules_day = season.editions.flat_map(&:schedules).pluck(:day)
    games_alternative_day = season.editions.flat_map(&:schedules).flat_map(&:games).pluck(:alternative_date).compact
    range_date = ((schedules_day + games_alternative_day).sort).then {|array| (array.first.monday? ? array.first : array.first.prev_occurring(:monday))..array.last}
    
    @displayed_date = Date.commercial(year, week, 1)
    loop do
      Rails.logger.info ">>>> Essai semaine : " + @displayed_date.inspect
      @week_calendar = Game.in_week_grouped_by_edition_and_schedule(@displayed_date.cweek, @displayed_date.cwyear)
      #byebug

      break if @week_calendar.present?
      
      if !range_date.include?(@displayed_date)
        if @displayed_date > range_date.max

          if params[:search_direction] == "futur"
            @disable_direction = "futur"
            
            break
          end
          # On est hors du range et au dessus alors on doit chercher dans le past
          params[:search_direction] == "past"
        elsif @displayed_date < range_date.min

          if params[:search_direction] == "past"
            @disable_direction = "past"
            
            break
          end
          # sinon on recherche dans le futur
          params[:search_direction] == "futur"
        end
      end
      @displayed_date = params[:search_direction] == "past" ? @displayed_date - 7.days : @displayed_date + 7.days
    end
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
      @schedule.designation = (@edition.letter || "J") + sprintf("%02d",i)
      @schedule.edition = @edition
      if @schedule.save
        previous_schedule = @schedule
        i += 1
        # then create next ones (date + 7 days) btw 2 schedules
        while i <= ((@edition.teams.count - 1 + (@edition.teams.count % 2)) * (@edition.second_leg? ? 2 : 1))
          # create new schedule 7 days later
          new_schedule = Schedule.create(
            edition: @edition,
            day: previous_schedule.day + 7,
            designation: (@edition.letter || "J") + sprintf("%02d",i)
          )
          previous_schedule = new_schedule
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
      schedule = schedule.next_in_edition
    end
    
    if @edition.second_leg?
      second_legs_games = first_legs_games.shuffle
      second_legs_games.each do |day|
        day.each do |game|
          if game.compact.count == 2
            new_game = Game.create(schedule: schedule)
            Result.create(game: new_game, team: game.last)
            Result.create(game: new_game, team: game.first)
          end
        end
        schedule = schedule.next_in_edition
      end
    end

  end

  private

  def schedule_params
    params.require(:schedule).permit(:day)
  end
end
