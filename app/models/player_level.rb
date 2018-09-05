class PlayerLevel < ActiveRecord::Base
  belongs_to :player
  belongs_to :world
  belongs_to :level

  before_validation :set_defaults, on: :create
  before_save       :set_totals

  def self.high_scores
    includes(:level, :world, :player).select("player_id, high_score, level_id, player_levels.world_id").where(status: 'completed').order(high_score: :desc)
  end

  def self.fast_times
    includes(:level, :world).select("player_id, fastest_time, level_id, player_levels.world_id").where(status: 'completed').order(fastest_time: :asc)
  end

  def self.max_collected
    includes(:level, :world).select("player_id, max_items_collected, level_id, player_levels.world_id").where(status: 'completed').order(max_items_collected: :desc)
  end

  private

  def set_defaults
    self.world_id = level.world_id
  end

  def set_totals
    self.gold_collected = gold_cartridges_collected + gold_cassettes_collected + gold_vhs_tapes_collected
  end
end
