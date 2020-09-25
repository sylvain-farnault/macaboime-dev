class FixColumnNameToCompetition < ActiveRecord::Migration[6.0]
  def change
    change_table :competitions do |t|
      t.rename :mark_win, :award_win
      t.rename :mark_draw, :award_draw
      t.rename :mark_lose, :award_lose
      t.rename :mark_forfeit, :award_forfeit
    end
  end
end
