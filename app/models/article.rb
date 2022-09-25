class Article < ApplicationRecord
  belongs_to :season
  belongs_to :edition

  has_many_attached :images

  validates :title, presence: true
  validates :content, presence: true
end
