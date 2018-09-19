class NewIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :culture_items, :culture_format_id
    add_index :achievements, :match_type
    add_index :worlds, :year
  end
end
