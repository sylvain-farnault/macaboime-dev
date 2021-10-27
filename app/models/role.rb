class Role < ApplicationRecord
  validates :label, presence: true, uniqueness: true
  has_many :user_roles
  has_many :users


  def self.method_missing(m, *args, &block)
    if Role.pluck(:label).include?(m.to_s)
      Role.find_by_label(m.to_s)
    else
      super
    end
    # object.send(m, *args, &block)
  end
end
