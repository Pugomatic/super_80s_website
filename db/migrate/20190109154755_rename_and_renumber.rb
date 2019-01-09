class RenameAndRenumber < ActiveRecord::Migration[5.2]
  def change
    a = Level.find_by(number: 6)
    b = Level.find_by(number: 7)
    a.update_attributes number: 7
    b.update_attributes number: 6
    a = Level.find_by(number: 12)
    b = Level.find_by(number: 15)
    a.update_attributes number: 15
    b.update_attributes number: 12
    Level.find_by(number: 17).update_attributes name: "Nuke 'em High'"
    Level.find_by(number: 18).update_attributes name: "Space Cadet"
    Level.find_by(number: 25).update_attributes name: "Electric Ave"
    Level.find_by(number: 42).update_attributes number: 44
    Level.find_by(number: 37).update_attributes number: 43
    Level.find_by(number: 41).update_attributes number: 42
    Level.find_by(number: 40).update_attributes number: 41
    Level.find_by(number: 39).update_attributes number: 40
    Level.find_by(number: 38).update_attributes number: 39
    Level.find_by(number: 36).update_attributes number: 38
    Level.find_by(number: 35).update_attributes number: 37, name: 'Helloween'
    Level.find_by(number: 34).update_attributes number: 35
    Level.find_by(number: 31).update_attributes number: 34
    a = Level.find_by(number: 32)
    b = Level.find_by(number: 33)
    a.update_attributes number: 33
    b.update_attributes number: 32
    Level.find_by(number: 30).update_attributes number: 31
    Level.find_by(number: 29).update_attributes number: 30
    Level.find_by(number: 28).update_attributes number: 29
    Level.find_by(number: 27).update_attributes number: 28

    Level.create! number: 27, name: 'Knight Raider', minigame: true
    Level.create! number: 36, name: 'Kablam!', minigame: true

    levels = Level.order('number asc')
    levels.each_with_index do |level, i|
      if level[i + 1]
        level.next_level = level[i + 1]
        level.save!
      end
    end
  end
end