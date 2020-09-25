class RenameTypeInCompetitions < ActiveRecord::Migration[6.0]
  def change
    rename_column :competitions, :type, :kind
  end
end
