class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.references :season, null: false, foreign_key: true
      t.references :edition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
