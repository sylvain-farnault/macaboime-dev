class Team < ApplicationRecord
  attr_accessor :name, :used_since, :resident
  has_many :team_names
  has_many :contestants
  has_many :editions, through: :contestants

  def label_name
    # TODO: has to be changed :
    # we need the right name regarding to edition.season.years
    team_names.last.name
  end
end
