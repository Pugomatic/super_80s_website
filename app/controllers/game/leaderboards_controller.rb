module Game
  class LeaderboardsController < ApplicationController
    layout  'game'

    def index
      @selected = :leaderboard

      if params[:year].blank? || params[:year] == "ALL"
        @year = :all
      else
        @year = params[:year]
      end

      if params[:level].blank? || params[:level] == "ALL"
        @level = :all
      else
        @level = params[:level]
      end

      conditions = {}
      conditions['worlds.year'] = @year unless @year == :all
      conditions['levels.month'] = @level unless @year == :all || @level == :all

      @high_scores =  PlayerLevel.where(conditions).high_scores.limit(20)
      @fast_times  =  PlayerLevel.where(conditions).fast_times.limit(20)
      @memo_items  =  PlayerLevel.where(conditions).max_collected.limit(20)
      @max_kills   =  PlayerLevel.where(conditions).max_kills.limit(20)
    end
  end
end