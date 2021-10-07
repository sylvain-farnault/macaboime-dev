class Stadium < ApplicationRecord
  KIND = %W[synthetic gravel grass]
  has_many :games

  validates :name, presence: true, uniqueness: true
  validates :kind,
            presence: true,
            inclusion: {
              in: KIND,
              message: "Error: %{value} is not a valid fiel kind." }


  def to_label
    "#{id} - #{name}"
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
