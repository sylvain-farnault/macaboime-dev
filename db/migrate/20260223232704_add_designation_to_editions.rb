class AddDesignationToEditions < ActiveRecord::Migration[6.0]
  def change
    add_column :editions, :designation, :string, default: "empty", null: false
  end
end
