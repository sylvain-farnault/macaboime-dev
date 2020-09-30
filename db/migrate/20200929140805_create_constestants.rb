class CreateConstestants < ActiveRecord::Migration[6.0]
  def change
    create_table :constestants do |t|
      t.references :edition, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
