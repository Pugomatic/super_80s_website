module Players
  class OmniauthCallbacksController < ::Devise::OmniauthCallbacksController
    def facebook
      @player = Player.from_omniauth(request.env["omniauth.auth"])

      if @player.persisted?
        sign_in @player, event: :authentication

        flash[:notice] = "Congratulations!  You will be notified when the competition begins."
        redirect_to game_profile_path @player
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_player_registration_url
      end
    end

    def failure
      flash[:error] = "There was a problem authenticating"
      redirect_to root_path
    end
  end
end
