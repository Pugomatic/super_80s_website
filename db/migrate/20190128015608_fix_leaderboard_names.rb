class FixLeaderboardNames < ActiveRecord::Migration[5.2]
  def change
    Leaderboard.find_by(label: 'high_scores').update_attributes(short_name: 'Full Game', name: 'Full Game Leaderboard')
  end
end
