class Season < ApplicationRecord
  has_many :editions

  validates :years, presence: true, uniqueness: true

  def to_param
    years
  end

end
