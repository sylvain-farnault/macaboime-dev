class CreateTeamNames < ActiveRecord::Migration[6.0]
  def change
    create_table :team_names do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
