class UpdateLeaderboardsAgain < ActiveRecord::Migration[5.2]
  def change
    data = {}

    %w(1980 1981 1982 1983 1984).each do |year|
      world = World.find_by(year: year)
      1.upto(8).each do |month|
        postfix = month == 8 ? 'boss' : month
        data["#{year}_#{postfix}"] = {level: world.levels.find_by(month: month), world: world}
      end
    end

    data.each do |label, attrs|
      Leaderboard.find_by(label: label).update_attributes!(attrs)
    end
  end
end
