class MakeLeaderboardsGreatAgain < ActiveRecord::Migration[5.2]
  def change
    Leaderboard.reset_column_information

    data = {
        'first_beta' => {kind: 'custom', short_name: 'First Beta', position: 1},
        'second_beta' => {kind: 'custom', short_name: 'Second Beta', position: 2},
        'break-in' => {kind: 'minigame', short_name: 'Break-in', position: 1, timeframe: 'minigame', stat: nil},
        'space_cadet' => {kind: 'minigame', short_name: 'Space Cadet', position: 2, timeframe: 'minigame', stat: nil},
        'knight_raider' => {kind: 'minigame', short_name: 'Knight Raider', position: 3, timeframe: 'minigame', stat: nil},
        'kablam' => {kind: 'minigame', short_name: 'Kablam', position: 4, timeframe: 'minigame', stat: nil},
        '1980' => {kind: 'world', short_name: '1980', position: 1, timeframe: 'world', stat: nil},
        '1981' => {kind: 'world', short_name: '1981', position: 2, timeframe: 'world', stat: nil},
        '1982' => {kind: 'world', short_name: '1982', position: 3, timeframe: 'world', stat: nil},
        '1983' => {kind: 'world', short_name: '1983', position: 4, timeframe: 'world', stat: nil},
        '1984' => {kind: 'world', short_name: '1984', position: 5, timeframe: 'world', stat: nil},
        'high_scores' => {kind: 'overall', short_name: 'High Scores', position: 1, timeframe: 'game', stat: nil},
        '1980_boss' => {kind: 'boss', short_name: '1980 Boss', position: 1, timeframe: 'level', stat: nil},
        '1981_boss' => {kind: 'boss', short_name: '1981 Boss', position: 2, timeframe: 'level', stat: nil},
        '1982_boss' => {kind: 'boss', short_name: '1982 Boss', position: 3, timeframe: 'level', stat: nil},
        '1983_boss' => {kind: 'boss', short_name: '1983 Boss', position: 4, timeframe: 'level', stat: nil},
        '1984_boss' => {kind: 'boss', short_name: '1984 Boss', position: 5, timeframe: 'level', stat: nil},
    }

    i = 1
    %w(1980 1981 1982 1983 1984).each do |year|
      1.upto(7).each do |month|
        data["#{year}_#{month}"] = {kind: 'level', short_name: "#{year}.#{month}", position: i, timeframe: 'level', stat: nil}
        i += 1
      end
    end

    data.each do |label, attrs|
      Leaderboard.find_by(label: label).update_attributes!(attrs)
    end
  end
end
