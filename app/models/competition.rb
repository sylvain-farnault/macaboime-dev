class Competition < ApplicationRecord
  has_many :editions

  validates :name, presence: true, uniqueness: true
  validates :kind,
            presence: true,
            inclusion: {
              in: %w(championship cup friendly),
              message: "Error: %{value} is not a valid competition." }
end
