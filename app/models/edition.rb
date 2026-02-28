class Edition < ApplicationRecord
  belongs_to :competition
  belongs_to :season
  has_many :contestants
  has_many :teams, through: :contestants
  has_many :schedules
  has_many :articles
  has_many :rankings

  validates :designation, presence: true
  validates :competition_id, uniqueness: { scope: [:season_id, :designation] }

  def label_for_select
    "#{self.season.years}/#{self.competition.kind}/#{self.competition.name}"
  end

  def ranking
    rankings.where(initial: false).last
  end

  def ranking_initial
    rankings.where(initial: true).last
  end

  def computed_ranking_datas
    # TODO : ranking_data should compute last ranking data and last ranking_initial data
    
    persisted_rankings = rankings
    persisted_rankings.any? ?
      persisted_rankings.last.data.deep_symbolize_keys :
      Competitions::Championship.new(edition: self).ranking_datas
  end
end
