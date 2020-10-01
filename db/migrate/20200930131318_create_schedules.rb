class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :edition, null: false, foreign_key: true
      t.date :day, null: false
      t.string :designation

      t.timestamps
    end
  end
end
