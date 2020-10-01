class CreateStadiums < ActiveRecord::Migration[6.0]
  def change
    create_table :stadiums do |t|
      t.string :name
      t.string :address
      t.string :type

      t.timestamps
    end
  end
end
