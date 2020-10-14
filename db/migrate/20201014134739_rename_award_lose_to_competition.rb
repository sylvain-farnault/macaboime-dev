class RenameAwardLoseToCompetition < ActiveRecord::Migration[6.0]
  def change
    rename_column :competitions, :award_lose, :award_loss
  end
end
