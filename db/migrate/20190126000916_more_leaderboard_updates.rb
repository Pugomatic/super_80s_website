class MoreLeaderboardUpdates < ActiveRecord::Migration[5.2]
  def change
    add_column  :leaderboards, :short_name, :string
    add_column  :leaderboards, :kind, :string
    add_column  :leaderboards, :position, :integer, default: 100

    Leaderboard.where(direct: false).each do |l|
      l.update_attribute :stat, 'game_score'
    end
  end
end
