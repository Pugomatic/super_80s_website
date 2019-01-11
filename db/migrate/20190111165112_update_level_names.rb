class UpdateLevelNames < ActiveRecord::Migration[5.2]
  def change
    Level.find_by(name: 'Chopper Commando').update_attribute :name, 'Die Harder'
    Level.find_by(name: "Nuke 'em High'").update_attribute :name, "Nuke 'em Higher"
  end
end
