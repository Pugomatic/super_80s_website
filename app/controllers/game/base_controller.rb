module Game
  class BaseController < ApplicationController
    layout  'game'

    before_action :ensure_logged_in


    protected

    def ensure_logged_in
      unless current_player
        redirect_to game_sign_ins_path
      end
    end
  end
end