class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates_presence_of :user, :role
  validates :user, uniqueness: { scope: :role, message: "can\'t have twice the same role!" }
  validates :role, uniqueness: { scope: :user, message: ": This user is already an %{value}" }
end
