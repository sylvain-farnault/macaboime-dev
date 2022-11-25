class Season < ApplicationRecord
  has_many :editions
  has_many :articles

  validates :years, presence: true, uniqueness: true

  def to_param
    years
  end

end
