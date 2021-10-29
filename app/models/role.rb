class Role < ApplicationRecord
  validates :label, presence: true, uniqueness: true
  has_many :user_roles
  has_many :users, through: :user_roles

  # Role Class will respond to :role_name method return a role instance
  def self.method_missing(m, *args, &block)
    if Role.pluck(:label).include?(m.to_s)
      Role.find_by_label(m.to_s)
    else
      super
    end
    # object.send(m, *args, &block)
  end

  def to_s
    label
  end
end
