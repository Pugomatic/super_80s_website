class SecondLeaderboard < ActiveRecord::Migration[5.2]
  def change
    lb = Leaderboard.create! name: 'Beta Tournament: Part II', stat: 'level_score', label: 'second_beta', sorting: 'levels.number DESC, value DESC', joiner_tables: 'level player', metric: 'high_score', timeframe: 'game'

    lb.leaderboard_players.create player: Player.find_by(handle: 'max.power')
  end
end
