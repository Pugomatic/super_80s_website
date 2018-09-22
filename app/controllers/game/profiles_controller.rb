module Game
  class ProfilesController < BaseController
    before_action   :set_player, only: [:show]
    before_action   :set_paths

    def index
      @selected = :profile
      @players = Player.public
    end

    def show
      @selected = :profile
      @achievements = @player.achievements.order(:sort_name)
      @counts = {}
      @counts[:cassettes] = @player.culture_items.cassettes.count
      @counts[:cartridges] = @player.culture_items.cartridges.count
      @counts[:vhs_tapes] = @player.culture_items.vhs_tapes.count

      @items = {}

      @worlds = @player.player_worlds.includes(:world).sort_by(&:year)

      @achievements.with_items.each do |a|
        @items[a.id] = CultureItem.select('player_items.player_id', 'id', 'funny_title').includes(:player_items, :culture_format).where('player_items.player_id' => @player.id, 'id' => a.achievement_items.map(&:culture_item_id))
      end

      @high_scores = @player.player_levels.high_scores.limit(5)
      @fast_times = @player.player_levels.fast_times.limit(5)
      @memo = @player.player_levels.max_collected.limit(5)
      @max_kills = @player.player_levels.max_kills.limit(5)

      @current_level = @player.top_completed_level&.next_level
    end
  end
end