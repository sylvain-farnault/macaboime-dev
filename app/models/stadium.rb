class Stadium < ApplicationRecord
  has_many :games

  validates :name, presence: true, uniqueness: true
  validates :kind,
            presence: true,
            inclusion: {
              in: %w(synthetic gravel),
              message: "Error: %{value} is not a valid fiel kind." }


  def to_label
    "#{id} - #{name}"
  end
end
