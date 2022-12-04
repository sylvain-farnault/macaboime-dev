class AddResidentColumnToTeams < ActiveRecord::Migration[6.0]
  def up
    add_column :teams, :resident, :boolean
  end
end
