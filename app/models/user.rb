class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles

  # user instance will respond to :admin? :player? (any role_name as :role_name?)
  def method_missing(m, *args, &block)
    if Role.pluck(:label).include?(m.to_s.gsub('?', '')) && m[-1] == '?'
      self.roles.pluck(:label).include?(m.to_s.gsub('?', '')) ? true : false
    else
      super
    end
  end

  def to_s
    email
  end
end
