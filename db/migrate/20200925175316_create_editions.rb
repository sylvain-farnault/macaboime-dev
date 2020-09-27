class CreateEditions < ActiveRecord::Migration[6.0]
  def change
    create_table :editions do |t|
      t.references :competition, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
