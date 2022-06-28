class Article < ApplicationRecord
  belongs_to :season
  belongs_to :edition

  has_rich_text :content
  has_many_attached :images

  validates :title, presence: true

end
