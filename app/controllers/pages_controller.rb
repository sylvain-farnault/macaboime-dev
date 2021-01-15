class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    # GET current championship edition instance that need to be send to the partial
    # See later the possibility to get season_years into path macaboime.fr/2020-2021
    current_year = Time.now.year
    start_year =
      (Time.now > Time.new(current_year,8,15)) ?
      current_year : (current_year - 1)
    season_years = start_year.to_s + "-" + (start_year + 1).to_s
    season = Season.where(years: season_years)
    competition = Competition.where(kind: "championship")
    @current_championship_edition = Edition.find_by(season: season, competition: competition)


    @ranking_datas = {}
    # All teams contestant in that Edition
    @current_championship_edition.teams.each { |team|
      @ranking_datas[team.id] = initialize_datas
      @ranking_datas[team.id][:id] = team.id
      @ranking_datas[team.id][:name] = team.label_name
    }

    @current_championship_edition.schedules.each { |schedule|
      schedule.games.each { |game|
        if game.played?
          @ranking_datas[game.results.first.team_id][:goals_for] += game.results.first.mark
          @ranking_datas[game.results.last.team_id][:goals_for] += game.results.last.mark

          @ranking_datas[game.results.first.team_id][:goals_against] += game.results.last.mark
          @ranking_datas[game.results.last.team_id][:goals_against] += game.results.first.mark

          diff = game.results.first.mark - game.results.last.mark
          @ranking_datas[game.results.first.team_id][:goals_diff] += diff
          @ranking_datas[game.results.last.team_id][:goals_diff] -= diff

          if diff > 0
            @ranking_datas[game.results.first.team_id][:points] += @current_championship_edition.competition.award_win
            @ranking_datas[game.results.first.team_id][:win] += 1
            @ranking_datas[game.results.last.team_id][:points] += @current_championship_edition.competition.award_loss
            @ranking_datas[game.results.last.team_id][:loss] += 1
          elsif diff < 0
            @ranking_datas[game.results.last.team_id][:points] += @current_championship_edition.competition.award_win
            @ranking_datas[game.results.last.team_id][:win] += 1
            @ranking_datas[game.results.first.team_id][:points] += @current_championship_edition.competition.award_loss
            @ranking_datas[game.results.first.team_id][:loss] += 1
          else
            @ranking_datas[game.results.first.team_id][:points] += @current_championship_edition.competition.award_draw
            @ranking_datas[game.results.first.team_id][:draw] += 1
            @ranking_datas[game.results.last.team_id][:points] += @current_championship_edition.competition.award_draw
            @ranking_datas[game.results.last.team_id][:draw] += 1
          end
            @ranking_datas[game.results.first.team_id][:played] += 1
            @ranking_datas[game.results.last.team_id][:played] += 1

        end
      }
    }
    # raise
    # @ranking_datas = @ranking_datas.sort_by { |k,v| -v[:points]; -v[:goals_diff]}.to_h
    @ranking_datas = @ranking_datas.sort_by { |k,v| [-v[:points], -v[:goals_diff], -v[:goals_for]] }
  end

  def power

  end

  private

  def initialize_datas
    {
      id: 0,
      name: "",
      played: 0,
      win: 0,
      loss: 0,
      draw: 0,
      points: 0,
      goals_for: 0,
      goals_against: 0,
      goals_diff: 0
    }
  end
end
