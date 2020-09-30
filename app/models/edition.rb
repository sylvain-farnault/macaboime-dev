class Edition < ApplicationRecord
  belongs_to :competition
  belongs_to :season

  has_many :teams, through: :contestants

  validates :competition_id, uniqueness: { scope: :season_id }
end
