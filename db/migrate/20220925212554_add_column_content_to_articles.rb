class AddColumnContentToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :content, :text
  end
end
