class Season < ApplicationRecord

  validates :years, presence: true, uniqueness: true

  def to_param
    years
  end
end
