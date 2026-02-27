class AddLetterToEditions < ActiveRecord::Migration[6.0]
  def change
    add_column :editions, :letter, :string
  end
end
