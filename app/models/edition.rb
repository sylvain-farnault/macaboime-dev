class Edition < ApplicationRecord
  belongs_to :competition
  belongs_to :season
end
