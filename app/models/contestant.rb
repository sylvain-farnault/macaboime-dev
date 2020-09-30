class Contestant < ApplicationRecord
  belongs_to :edition
  belongs_to :team

  validates :team_id, uniqueness: { scope: :edition_id }
end
