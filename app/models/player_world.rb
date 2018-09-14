class PlayerWorld < ActiveRecord::Base
  include PlayerLeaderboards

  belongs_to :world

  def year
    world.year
  end

  def label
    world.year
  end

  def self.leaderboard(field, order = :desc)
    includes(:player, :world).select("player_id, #{field}, world_id").where("#{field} > 0").where(status: %w(rescued finished)).order(field => order)
  end
end
