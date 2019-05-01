module Game
  class LeaderboardsController < BaseController
    layout  'game'

    before_action   :set_paths

    def show
      @selected = :leaderboard
      @leaderboard = Leaderboard.find_by(label: params[:id])
      @dir = 'default'
      if @leaderboard.label =~ /beta$/
        @dir = @leaderboard.label
      else
        @dir = @leaderboard.metric
      end
    end

    def join
      redirect_to '/game/beta_competition'
    end

    def index
      @selected = :leaderboard

      @leaderboards = Leaderboard.all.order(position: :asc).group_by(&:kind)
   end
  end
end