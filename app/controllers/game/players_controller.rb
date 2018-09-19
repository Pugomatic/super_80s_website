module Game
  class PlayersController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      if params[:game_api_key] == ENV['GAME_API_KEY']
        Player.from_game(params)
        head :ok
      else
        head :not_implemented
      end
    end
  end
end