class AddMoreLeaderboards < ActiveRecord::Migration[5.2]
  def change
    Level.all.each do |l|
      l.minigame = false unless l.minigame
      l.boss = false unless l.boss
      l.save!

      if l.minigame
        nil
      elsif l.boss
        Leaderboard.create!(name: "#{l.name} (Boss)", stat: 'level_score', label: "#{l.world.year}_boss", metric: 'high_score', locked: false, closed: false, direct: true)
      else
        Leaderboard.create!(name: l.name, stat: 'level_score', label: "#{l.world.year}_#{l.month}", metric: 'high_score', locked: false, closed: false, direct: true)
      end
    end
  end
end
