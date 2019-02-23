class FinalBeta < ActiveRecord::Migration[5.2]
  def change
    Leaderboard.create! name: 'Final Beta Competition', stat: 'game_score', label: 'third_beta',
        joiner_tables: 'level player', sorting: 'levels.number DESC, value DESC',
        timeframe: 'game', metric: 'high_score', locked: false,
        ending_at: Date.parse("March 11, 2019").to_time + 1.day - 1.second,
        closed: false, direct: false, short_name: 'Third Beta',
        kind: 'custom', position: 3
  end
end
