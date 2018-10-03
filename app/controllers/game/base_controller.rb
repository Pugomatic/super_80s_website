module Game
  class BaseController < ApplicationController
    layout  'game'

    protected

    def set_paths
      if @player || session[:player_id] || current_player
        player = @player || session[:player_id] || current_player
        if player.respond_to?(:handle)
          @player_name = player.handle
        else
          @player_name = Player.get(session[:player_id])&.handle
        end

        @profile_path = current_player && game_profile_path(current_player)
        @disco_path = (@player || current_player) && game_profile_discographies_path(@player || current_player)

      else
        @profile_path = game_profiles_path
        @player_name = 'Players'
        @disco_path = nil
      end
    end

    def set_player
      @player = Player.get(params[:profile_id] || params[:id])

      # if ! @player.public? && current_player != @player
      #   head :unauthorized
      #   return false
      # end

      true
    end

    def ensure_logged_in
      unless current_player
        redirect_to game_sign_ins_path
      end
    end
  end
end