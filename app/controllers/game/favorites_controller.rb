module Game
  class FavoritesController < ApplicationController
    layout :none

    def update
      head :ok
    end
  end
end