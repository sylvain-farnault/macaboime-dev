class ChangeDefaultValueForForfeitToResult < ActiveRecord::Migration[6.0]
  def change
    change_column :results, :forfeit, :boolean, :default => false
  end
end
