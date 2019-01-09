class AddFieldsToLeaderboard < ActiveRecord::Migration[5.2]
  def change
    add_column :leaderboards, :direct, :boolean, default: false
    add_column :leaderboards, :level_id, :integer
    add_column :leaderboards, :world_id, :integer
  end
end
