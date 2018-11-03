class AddFieldsToLeaderboards < ActiveRecord::Migration[5.2]
  def change
    add_column :leaderboards, :closed, :boolean, default: false
  end
end
