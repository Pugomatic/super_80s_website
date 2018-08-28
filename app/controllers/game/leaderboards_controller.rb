module Game
  class LeaderboardsController < ApplicationController
    layout  'game'

    def index
      @selected = :leaderboard
    end
  end
end