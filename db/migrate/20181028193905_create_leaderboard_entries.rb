class CreateLeaderboardEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboard_entries do |t|
      t.references :leaderboard, foreign_key: true
      t.references :player, foreign_key: true
      t.references :level, foreign_key: true
      t.integer :value
    end
    add_column  :leaderboards, :joiner_tables, :string, default: 'player'
    add_column  :leaderboards, :sorting, :string, default: 'value DESC'
    add_column  :leaderboards, :timeframe, :string, default: 'game'
    add_column  :leaderboards, :metric, :string, default: 'high_score'
    add_column  :leaderboards, :locked, :boolean, default: false
    add_column  :leaderboards, :ending_at, :datetime

    Leaderboard.last.update_attributes sorting: 'levels.number DESC, value DESC', joiner_tables: 'level player', metric: 'high_score', timeframe: 'game'
  end
end
