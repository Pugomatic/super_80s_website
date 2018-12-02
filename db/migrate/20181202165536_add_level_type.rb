class AddLevelType < ActiveRecord::Migration[5.2]
  def change
    add_column :levels, :level_type, :integer, default: 0

    %w(9 18 27 36).each do |n|
      Level.find(n).update_attribute :level_type, 2
    end

    %w(8 17 26 35 44).each do |n|
      Level.find(n).update_attribute :level_type, 1
    end

    Level.find(31).update_attribute :level_type, -1
  end
end
