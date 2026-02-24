class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.json :data
      t.references :edition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
