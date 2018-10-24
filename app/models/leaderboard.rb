class Leaderboard < ApplicationRecord
  has_many  :leaderboard_players
  has_many  :players, through: :leaderboard_players

  attr_accessor :leaders

  def leaders
    if stat == 'level_score'
      players.top_level_board.to_a
    end
  end
end
