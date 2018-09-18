module Game
  class DataController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      player = Player.find_by(email: params[:email], uid: params[:uid])

      if player
        player.update_from_game! params
        head :ok
      else
        head :not_found
      end
    end
  end
end

