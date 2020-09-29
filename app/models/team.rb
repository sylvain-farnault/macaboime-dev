class Team < ApplicationRecord
  attr_accessor :name, :used_since
  has_many :team_names
end
