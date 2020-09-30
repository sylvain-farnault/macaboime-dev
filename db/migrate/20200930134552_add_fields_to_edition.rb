class AddFieldsToEdition < ActiveRecord::Migration[6.0]
  def change
    add_column :editions, :second_legs_offset, :integer, default: 2
    add_column :editions, :total_rounds, :integer
  end
end
