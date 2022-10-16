# /home/sylvinho/code/sylvain-farnault/macaboime-dev/lib/competitions/championship/championship.rb
module Competitions
  class Championship
    def initialize(attributes = {})
      @edition = attributes[:edition]
    end

    def ranking_datas
      ranking_datas = {}
      # All teams contestant in that Edition
      @edition.teams.each { |team|
        ranking_datas[team.id] = initialize_datas
        ranking_datas[team.id][:id] = team.id
        ranking_datas[team.id][:name] = team.label_name
      }

      @edition.schedules.each { |schedule|
        schedule.games.each { |game|
          if game.played?
            ranking_datas[game.results.first.team_id][:goals_for] += game.results.first.mark
            ranking_datas[game.results.last.team_id][:goals_for] += game.results.last.mark

            ranking_datas[game.results.first.team_id][:goals_against] += game.results.last.mark
            ranking_datas[game.results.last.team_id][:goals_against] += game.results.first.mark

            diff = game.results.first.mark - game.results.last.mark
            ranking_datas[game.results.first.team_id][:goals_diff] += diff
            ranking_datas[game.results.last.team_id][:goals_diff] -= diff

            if diff > 0
              ranking_datas[game.results.first.team_id][:points] += @edition.competition.award_win
              ranking_datas[game.results.first.team_id][:win] += 1
              ranking_datas[game.results.last.team_id][:points] += @edition.competition.award_loss
              ranking_datas[game.results.last.team_id][:loss] += 1
            elsif diff < 0
              ranking_datas[game.results.last.team_id][:points] += @edition.competition.award_win
              ranking_datas[game.results.last.team_id][:win] += 1
              ranking_datas[game.results.first.team_id][:points] += @edition.competition.award_loss
              ranking_datas[game.results.first.team_id][:loss] += 1
            else
              ranking_datas[game.results.first.team_id][:points] += @edition.competition.award_draw
              ranking_datas[game.results.first.team_id][:draw] += 1
              ranking_datas[game.results.last.team_id][:points] += @edition.competition.award_draw
              ranking_datas[game.results.last.team_id][:draw] += 1
            end
            ranking_datas[game.results.first.team_id][:played] += 1
            ranking_datas[game.results.last.team_id][:played] += 1

          end
        }
      }

      ranking_datas.sort_by { |k,v| [-v[:points], -v[:goals_diff], -v[:goals_for]] }
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
end
