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

      @leaderboards = {
          overall: [],
          minigame: [],
          world: [],
          level: [],
          custom: []
      }

      Leaderboard.all.order(created_at: :desc) do |l|
        if l.direct
          if l.minigame
          case l.timeframe
          when 'game'
          when 'world'
          when 'level'
          when 'minigame'
          end
        else
          @leaderboards[:custom] << l
        end
      end

      # @top_level_board = Player.top_level_board.to_a

      # if params[:year].blank? || params[:year] == "ALL"
      #   @year = :all
      # else
      #   @year = params[:year]
      # end
      #
      # if params[:level].blank? || params[:level] == "ALL"
      #   @level = :all
      # else
      #   @level = params[:level]
      # end
      #
      # if @year != :all && @level != :all
      #   # level rank
      #   @high_scores =  PlayerLevel.where('worlds.year' => @year, 'levels.month' => @level).high_scores.limit(20)
      #   @fast_times  =  PlayerLevel.where('worlds.year' => @year, 'levels.month' => @level).fast_times.limit(20)
      #   @memo_items  =  PlayerLevel.where('worlds.year' => @year, 'levels.month' => @level).max_collected.limit(20)
      #   @max_kills   =  PlayerLevel.where('worlds.year' => @year, 'levels.month' => @level).max_kills.limit(20)
      # elsif @year != :all
      #   # world rank
      #   @high_scores =  PlayerWorld.where('worlds.year' => @year).high_scores.limit(20)
      #   @memo_items  =  PlayerWorld.where('worlds.year' => @year).max_collected.limit(20)
      #   @max_kills   =  PlayerWorld.where('worlds.year' => @year).max_kills.limit(20)
      #   @fast_times  =  PlayerWorld.where('worlds.year' => @year).fast_times.limit(20)
      # else
      #   # game rank
      #   @high_scores =  PlayerTotal.high_scores.limit(20)
      #   @memo_items  =  PlayerTotal.max_collected.limit(20)
      #   @max_kills   =  PlayerTotal.max_kills.limit(20)
      #   @fast_times  =  PlayerTotal.fast_times.limit(20)
      # end
      #
      # @space_ace = PlayerLevel.where('worlds.year' => '1980', 'levels.month' => '9').high_scores.limit(20)
    end
  end
end