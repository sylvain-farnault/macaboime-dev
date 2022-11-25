class Article < ApplicationRecord
  MAX_CONTENT_LENGHT = 144

  belongs_to :season
  belongs_to :edition

  has_many_attached :images

  validates :title, presence: true
  validates :content, presence: true
end
