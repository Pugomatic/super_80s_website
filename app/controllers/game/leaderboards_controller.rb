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
      if current_player

        @selected = :leaderboard

        lb = Leaderboard.find(params[:id])

        if lb.open?
          lb.join!(current_player)
          flash[:notice] = "You have been entered into the tournament"
          redirect_to game_leaderboard_path(lb.label)
        else
          flash[:notice] = "You cannot join the tournament at this time"
          redirect_to game_leaderboard_path(lb.label)
        end
      else
        redirect_to '/game/beta_competition'
      end
    end

    def index
      @selected = :leaderboard

      @leaderboards = Leaderboard.all.order(position: :asc).group_by(&:kind)
   end
  end
end