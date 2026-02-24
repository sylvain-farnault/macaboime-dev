class Ranking < ApplicationRecord
  belongs_to :edition
  serialize :data, Hash
end
