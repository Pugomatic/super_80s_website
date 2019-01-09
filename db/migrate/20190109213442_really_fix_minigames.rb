class ReallyFixMinigames < ActiveRecord::Migration[5.2]
  def change
    Level.find_by(number: 27).update_attribute :world_id, World.find_by(year: '1982').id
    Level.find_by(number: 36).update_attribute :world_id, World.find_by(year: '1983').id
  end
end
