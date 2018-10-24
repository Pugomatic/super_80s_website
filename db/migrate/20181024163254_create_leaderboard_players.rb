class CreateLeaderboardPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboard_players do |t|
      t.references :leaderboard, foreign_key: true
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
