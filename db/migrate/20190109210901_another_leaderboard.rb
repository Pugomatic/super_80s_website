class AnotherLeaderboard < ActiveRecord::Migration[5.2]
  def change
    Leaderboard.create!(name: "High Score (Overall)", stat: 'game_score', label: 'high_scores', metric: 'high_score', locked: false, closed: false, direct: true)
  end
end
