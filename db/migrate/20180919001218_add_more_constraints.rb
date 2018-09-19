class AddMoreConstraints < ActiveRecord::Migration[5.2]
  def change
    add_index :achievement_items, [:achievement_id, :culture_item_id], name: "i_achievement_items_uac", unique: true
  end
end
