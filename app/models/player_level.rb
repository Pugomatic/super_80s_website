class PlayerLevel < ApplicationRecord
  include PlayerLeaderboards

  belongs_to :level
  belongs_to :player

  def set(data)
    self.fastest_time = (data[:fastest_time].to_f * 1000).round
    self.high_score = data[:high_score]
    self.plays = data[:plays]
    self.wins = data[:wins]
    self.tries = data[:tries]
    self.status = data[:status]
    self.max_kills = data[:max_kills]
    self.max_items_collected = data[:max_items_collected]
    self.max_cassettes_collected = data[:max_cassettes_collected]
    self.max_vhs_tapes_collected = data[:max_vhs_tapes_collected]
    self.max_cartridges_collected = data[:max_cartridges_collected]
    self.gold_cassettes_collected = data[:gold_cassettes_collected]
    self.gold_vhs_tapes_collected = data[:gold_vhs_tapes_collected]
    self.gold_cartridges_collected = data[:gold_cartridges_collected]
  end

  def label
    "#{world.year}.#{level.month}"
  end

  def world
    level.world
  end

  def self.leaderboard(field, order = :desc)
    includes(:player, level: :world).select("player_id, #{field}, level_id").where("status = ? AND #{field} > 0", 'completed').order(field => order)
  end
end
