class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :label, null: false

      t.timestamps
    end
    add_index :roles, :label, unique: true
  end
end
