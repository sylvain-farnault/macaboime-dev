class Edition < ApplicationRecord
  belongs_to :competition
  belongs_to :season
  has_many :contestants
  has_many :teams, through: :contestants
  has_many :schedules

  validates :competition_id, uniqueness: { scope: :season_id }
end
