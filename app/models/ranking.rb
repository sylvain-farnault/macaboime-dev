class Ranking < ApplicationRecord
  belongs_to :edition
  # serialize :data, Hash => Ruby already do that by default on json type column
end
