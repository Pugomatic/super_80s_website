module Game
  class DataController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      player = Player.find_by(email: params[:email], uid: params[:uid])
      player.update_from_game! params

      head :ok
    end
  end
end

