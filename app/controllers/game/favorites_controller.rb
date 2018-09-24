module Game
  class FavoritesController < ApplicationController
    layout :none

    def update
      if current_player
        current_player.player_items.find(params[:id]).update_attribute(:favorite, params[:fave] == "true")
      end

      head :ok
    end
  end
end