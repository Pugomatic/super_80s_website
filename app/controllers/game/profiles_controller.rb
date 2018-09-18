module Game
  class ProfilesController < BaseController
    def index
      @selected = :profile
      @achievements = current_player.achievements.order(:sort_name)
      @counts = {}
      @counts[:cassettes] = current_player.culture_items.cassettes.count
      @counts[:cartridges] = current_player.culture_items.cartridges.count
      @counts[:vhs_tapes] = current_player.culture_items.vhs_tapes.count

      @items = {}

      @worlds = current_player.player_worlds.includes(:world).sort_by(&:year)

      @achievements.with_items.each do |a|
        @items[a.id] = CultureItem.select('player_items.player_id', 'id', 'funny_title').includes(:player_items).where('player_items.player_id' => current_player.id, 'id' => a.achievement_items.map(&:culture_item_id))
      end

      @high_scores = current_player.player_levels.high_scores.limit(5)
      @fast_times = current_player.player_levels.fast_times.limit(5)
      @memo = current_player.player_levels.max_collected.limit(5)
      @max_kills = current_player.player_levels.max_kills.limit(5)

      @current_level = current_player.top_completed_level&.next_level
    end
  end
end