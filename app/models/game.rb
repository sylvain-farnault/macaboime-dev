class Game < ApplicationRecord
  belongs_to :schedule
  belongs_to :stadium, optional: true

  has_many :results

  validates :stadium, uniqueness: { allow_blank: true, allow_nil: true }
  validates :schedule, presence: true
end
