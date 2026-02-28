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

  def ranking # => Ranking instance
    # TODO : verif fonctionnement si pas de rankings ??
    rankings.where(initial: false).last
  end

  def ranking_initial # => Ranking instance
    rankings.where(initial: true).last
  end

  def ranking_datas # => Ranking#data mapped for treatment
    datas = 
      ranking.present? ?
          ranking.data :
          Competitions::Championship.new(edition: self).ranking_datas

    datas.to_a.map{|data| [data[0].to_i, data[1].deep_symbolize_keys] }.to_h
  end

  def ranking_initial_datas # => Ranking#data mapped for treatment
    datas = 
      ranking_initial.present? ?
          ranking_initial.data :
          {}

    datas.to_a.map{|data| [data[0].to_i, data[1].deep_symbolize_keys] }.to_h
  end

  def computed_ranking_datas
    # TODO : ranking_data should compute last ranking data and last ranking_initial data
    
    # d.to_a.map{|data| [data[0].to_i, data[1].deep_symbolize_keys] }.to_h
    # pour convertir data from DB => { <int_ID> => {symbols as keys}, ...}
    
    filtered_initial_datas = 
      ranking_initial_datas.present? ?
        ranking_initial_datas.select { |key, _| ranking_datas.keys.include?(key) } :
        {}

    ranking_datas.deep_merge(filtered_initial_datas){ |key, val_a, val_b| 
      [:id, :name].include?(key) ? val_a : val_a + val_b
    }.sort_by { |k,v| [-v[:points], -v[:goals_diff], -v[:goals_for], v[:name]] }.to_h
  end
end
