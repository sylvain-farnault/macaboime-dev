class CreateCompetitions < ActiveRecord::Migration[6.0]
  def change
    create_table :competitions do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
