class Article < ApplicationRecord
  belongs_to :season
  belongs_to :edition

  has_rich_text :content

  validates :title, presence: true

end
