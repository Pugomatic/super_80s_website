module Game
  class PlayersController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      Player.from_game(params)

      head :ok
    end
  end
end