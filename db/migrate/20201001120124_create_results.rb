class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :team, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :mark
      t.integer :penalty_mark
      t.integer :points_award
      t.boolean :forfeit

      t.timestamps
    end
  end
end
