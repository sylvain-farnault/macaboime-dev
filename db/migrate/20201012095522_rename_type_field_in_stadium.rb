class RenameTypeFieldInStadium < ActiveRecord::Migration[6.0]
  def change
    rename_column :stadiums, :type, :kind
  end
end
