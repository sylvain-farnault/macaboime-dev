class Competition < ApplicationRecord
  belongs_to :season

  validates :season, presence: true
  validates :type,
            presence: true,
            inclusion: {
              in: %w(championship cup friendly),
              message: "Error: %{value} is not a valid competition." }
end
