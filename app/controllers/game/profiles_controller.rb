module Game
  class ProfilesController < BaseController
    before_action   :set_player, only: [:show]
    before_action   :set_paths

    def index
      @selected = :list
      @players = Player.public(current_player)
    end

    def edit

    end

    def update
      current_player.update_attributes(player_params)

      redirect_to game_profile_path(current_player)
    end

    def show
      @selected = :profile
      @current_level = @player.top_completed_level&.next_level

      if params[:stat]
        @metric = params[:stat]
        case params[:stat]
        when :score
          @list = @player.player_levels.high_scores
        when :time
          @list = @player.player_levels.fast_times
        when :kills
          @list = @player.player_levels.max_kills
        when :memo
          @list = @player.player_levels.max_collected
        when :tries
          @list = @player.player_levels.hardest
        when :plays
          @list = @player.player_levels.most_played
        else
          @metric = ''
        end

        render 'game/profiles/list'
      else
        @achievements = @player.achievements.order(:sort_name)
        @counts = {}
        @counts[:cassettes] = @player.culture_items.cassettes.count
        @counts[:cartridges] = @player.culture_items.cartridges.count
        @counts[:vhs_tapes] = @player.culture_items.vhs_tapes.count

        @favorites = @player.favorites
        @items = {}

        @worlds = @player.player_worlds.includes(:world).sort_by(&:year).reject {|world| world.status == "DESTROYED"}

        @achievements.with_items.each do |a|
          @items[a.id] = PlayerItem.includes(culture_item: [:culture_format]).select('player_id', 'culture_item_id', 'culture_items.funny_title').where('player_items.player_id' => @player.id, 'culture_items.id' => a.achievement_items.map(&:culture_item_id))
        end

        @high_scores = @player.player_levels.high_scores.limit(3)
        @fast_times = @player.player_levels.fast_times.limit(3)
        @memo = @player.player_levels.max_collected.limit(3)
        @max_kills = @player.player_levels.max_kills.limit(3)
        @most_played = @player.player_levels.most_played.limit(3)
        @hardest = @player.player_levels.hardest.limit(3)
      end
    end

    private

    def player_params
      params.require(:player).permit(:name, :handle, :tagline)
    end
  end
end