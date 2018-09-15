class PlayerTotal < ApplicationRecord
  include PlayerLeaderboards

  def label
    "GAME"
  end

  def self.leaderboard(field, order = :desc)
    includes(:player).select("player_id, #{field}").where("status = ? AND #{field} > 0", 'completed').order(field => order)
  end
end