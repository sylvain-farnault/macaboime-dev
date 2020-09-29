class RenameUsedFromFieldToTeamName < ActiveRecord::Migration[6.0]
  def change
    rename_column :team_names, :used_from, :used_since
  end
end
