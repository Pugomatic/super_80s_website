module Game
  class PlayersController < ApplicationController
    # protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    def create
      if params[:game_api_key] == ENV['GAME_API_KEY']

        if params[:fb_data]
          Player.from_game(params)
        elsif player = Player.find_by(uid: params[:uid])
          player.update_from_game! params
        else
          head :not_found
          return
        end

        head :ok
      else
        head :not_implemented
      end
    end
  end
end