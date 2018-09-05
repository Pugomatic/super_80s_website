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

      @worlds = ["DESTROYED", "DESTROYED", "DESTROYED", "DESTROYED", "DESTROYED"]

      %w(0 1 2 3 4).each do |y|
        if @achievements.find {|a| a.sort_name == "rescued_198#{y}"}
          @worlds[y.to_i] = "RESCUED"
        end
      end

      @achievements.with_items.each do |a|
        @items[a.id] = current_player.culture_items.where(id: a.achievement_items.map(&:culture_item_id))
      end

      @high_scores = current_player.player_levels.high_scores

      @fast_times = current_player.player_levels.fast_times

      @memo = current_player.player_levels.max_collected
    end
  end
end