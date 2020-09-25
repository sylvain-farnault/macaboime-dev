class Competition < ApplicationRecord

  validates :name, presence: true
  validates :kind,
            presence: true,
            inclusion: {
              in: %w(championship cup friendly),
              message: "Error: %{value} is not a valid competition." }
end
