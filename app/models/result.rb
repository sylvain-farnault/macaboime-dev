class Result < ApplicationRecord
  belongs_to :team
  belongs_to :game

  has_many :teams

  def team_name
    self.team.team_names.last.name
  end
end
