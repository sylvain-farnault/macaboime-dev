class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles

  def method_missing(m, *args, &block)
    if Role.pluck(:label).include?(m.to_s.gsub('?', '')) && m[-1] == '?'
      self.roles.pluck(:label).include?(m.to_s.gsub('?', '')) ? true : false
    else
      super
    end
  end
end
