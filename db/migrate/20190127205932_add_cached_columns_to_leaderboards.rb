class AddCachedColumnsToLeaderboards < ActiveRecord::Migration[5.2]
  def change
    add_column :leaderboards, :player_count, :integer
    add_column :leaderboards, :top_score_name, :string
    add_column :leaderboards, :top_score, :integer
    add_column :leaderboards, :top_time_name, :string
    add_column :leaderboards, :top_time, :integer
    add_column :leaderboards, :top_score_level, :integer
    add_column :leaderboards, :top_time_level, :integer
  end
end
