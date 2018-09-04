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

      @achievements.with_items.each do |a|
        @items[a.id] = current_player.culture_items.where(id: a.achievement_items.map(&:culture_item_id))
      end
    end
  end
end