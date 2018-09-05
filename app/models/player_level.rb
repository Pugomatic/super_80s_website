class PlayerLevel < ActiveRecord::Base
  belongs_to :player
  belongs_to :world
  belongs_to :level

  before_validation :set_defaults, on: :create
  before_save       :set_totals

  def self.high_scores
    leaderboard('high_score')
  end

  def self.fast_times
    leaderboard('fastest_time', :asc)
  end

  def self.max_collected
    leaderboard('max_items_collected')
  end

  def self.max_kills
    leaderboard('max_kills')
  end

  def self.leaderboard(field, order = :desc)
    includes(:level, :world, :player).select("player_id, #{field}, level_id, player_levels.world_id").where("status = ? AND #{field} > 0", 'completed').order(field => order)
  end

  private

  def set_defaults
    self.world_id = level.world_id
  end

  def set_totals
    self.gold_collected = gold_cartridges_collected + gold_cassettes_collected + gold_vhs_tapes_collected
  end
end
