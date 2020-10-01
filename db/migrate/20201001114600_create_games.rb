class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :stadium, foreign_key: true
      t.date :alternative_date
      t.string :status

      t.timestamps
    end
  end
end
