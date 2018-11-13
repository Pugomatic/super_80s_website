class NewLevels < ActiveRecord::Migration[5.2]
  def change
    Level.where('number > 8').each do |l|
      l.update_attribute :number, l.number + 1
    end

    Level.find_by(name: 'Space Ace').update_attributes(name: 'Spaced Out', minigame: true)
    Level.create!(name: "Break-in'", world: World.find_by(year: '1980'), next_level: Level.find_by(name: 'Arcadia'), minigame: true, number: 9, month: 9)
  end
end
