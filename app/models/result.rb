class Result < ApplicationRecord
  belongs_to :team
  belongs_to :game

  has_many :teams
end
