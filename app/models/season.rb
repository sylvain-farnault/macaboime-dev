class Season < ApplicationRecord
  has_many :competitions

  def to_param
    years
  end
end
