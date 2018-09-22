class PlayerTotal < ApplicationRecord
  include PlayerLeaderboards

  def self.leaderboard(field, order = :desc)
    includes(:player).select("player_id, #{field}, players.leader").where("status = ? AND #{field} > 0", 'completed').where('players.leader' => true).order(field => order)
  end

  def label
    "GAME"
  end


  def clear!
    update_attributes! solid_gold: 0, plays: 0, wins: 0, high_score: 0, fastest_time: 0, status: "incomplete", max_kills: 0, max_cartridges_collected: 0, max_vhs_tapes_collected: 0, max_cassettes_collected: 0, max_items_collected: 0, gold_cassettes_collected: 0, gold_vhs_tapes_collected: 0, gold_cartridges_collected: 0, gold_collected: 0
  end
end