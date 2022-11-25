class Edition < ApplicationRecord
  belongs_to :competition
  belongs_to :season
  has_many :contestants
  has_many :teams, through: :contestants
  has_many :schedules
  has_many :articles

  validates :competition_id, uniqueness: { scope: :season_id }

  def label_for_select
    "#{self.season.years}/#{self.competition.kind}/#{self.competition.name}"
  end
end
