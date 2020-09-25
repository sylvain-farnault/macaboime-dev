class AddMarksAndRatioToCompetition < ActiveRecord::Migration[6.0]
  def change
    add_column :competitions, :mark_win, :integer, default: 3
    add_column :competitions, :mark_draw, :integer, default: 1
    add_column :competitions, :mark_lose, :integer, default: 0
    add_column :competitions, :mark_forfeit, :integer, default: 0
    add_column :competitions, :ratio_pts_by_match, :boolean, default: false
  end
end
