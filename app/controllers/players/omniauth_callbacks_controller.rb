module Players
  class OmniauthCallbacksController < ::Devise::OmniauthCallbacksController
    def twitter
      authenticate(:twitter)
    end

    def facebook
      authenticate(:facebook)
    end

    def google_oauth2
      authenticate(:google_oauth2)
    end

    def failure
      flash[:error] = "There was a problem authenticating"
      redirect_to root_path
    end

    private

    def authenticate(type)
      @player = Player.from_omniauth(request.env["omniauth.auth"])

      if @player.persisted?
        sign_in @player, event: :authentication

        flash[:notice] = "Congratulations!  If you don't receive a download link shortly, please email beta@super80sworld.com"
        redirect_to game_profile_path @player
      else

        if type == :facebook
          session["devise.facebook_data"] = request.env["omniauth.auth"]
        elsif type == :twitter
          session["devise.twitter_data"] = request.env["omniauth.auth"]
        elsif type == :google_oauth2
          session["devise.google_data"] = request.env["omniauth.auth"]
        end

        redirect_to new_player_registration_url
      end
    end
  end
end
