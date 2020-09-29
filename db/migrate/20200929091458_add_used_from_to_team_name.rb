class AddUsedFromToTeamName < ActiveRecord::Migration[6.0]
  def change
    add_column :team_names, :used_from, :date, null: false
    change_column :team_names, :name, :string, null: false
  end
end
