class AddNewLeaderboards < ActiveRecord::Migration[5.2]
  def change
    Level.where(minigame:true).each do |level|
      Leaderboard.create!(name: "#{level.name} Minigame", stat: 'level_score', label: level.name.parameterize(separator: '_'), metric: 'high_score', locked: false, closed: false, direct: true, level_id: level.id, world_id: level.world_id)
    end

    World.all.each do |world|
      Leaderboard.create!(name: "#{world.title} - #{world.year}", stat: 'world_score', label: world.year, metric: 'high_score', locked: false, closed: false, direct: true, world_id: world.id)
    end
  end
end
