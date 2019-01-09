class AddFieldsToPlayerLevels < ActiveRecord::Migration[5.2]
  def change
    add_column :player_levels, :gold_finishes, :integer, default: 0
  end
end
