class Schedule < ApplicationRecord
  # attr_accessor :first_day
  belongs_to :edition
  has_many :games


  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end

end
