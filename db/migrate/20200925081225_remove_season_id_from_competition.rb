class RemoveSeasonIdFromCompetition < ActiveRecord::Migration[6.0]
  def change
    remove_reference :competitions, :season, null: false, foreign_key: true
  end
end
