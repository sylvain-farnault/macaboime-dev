class Game < ApplicationRecord
  belongs_to :schedule
  belongs_to :stadium, optional: true

  has_many :results
  accepts_nested_attributes_for :results
  default_scope { order(:id) }

  # validates :stadium, uniqueness: { allow_blank: true, allow_nil: true }
  validates :schedule, presence: true

  def played?
    status == "played"
  end
end
