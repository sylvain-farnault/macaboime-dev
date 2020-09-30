class Team < ApplicationRecord
  attr_accessor :name, :used_since
  has_many :team_names
  has_many :editions, through: :contestants

  def label_name
    team_names.last.name
  end
end
