class AddSecondLegToEditions < ActiveRecord::Migration[6.0]
  def up
    add_column :editions, :second_leg, :boolean, default: true
  end

  def down
    remove_column :editions, :second_leg
  end
end
