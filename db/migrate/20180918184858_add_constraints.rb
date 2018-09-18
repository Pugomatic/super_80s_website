class AddConstraints < ActiveRecord::Migration[5.2]
  def change
    add_index :player_achievements, [:player_id, :achievement_id], name: "i_player_achievements_upa", unique: true
    add_index :player_items, [:player_id, :culture_item_id], name: "i_player_items_upi", unique: true
    add_index :player_levels, [:player_id, :level_id], name: "i_player_levels_upl", unique: true
    add_index :player_totals, [:player_id], name: "i_player_totals_up", unique: true
    add_index :player_worlds, [:player_id, :world_id], name: "i_player_worlds_upw", unique: true
  end
end
