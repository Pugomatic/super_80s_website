class UsersController < ApplicationController
  invisible_captcha only: [:create], honeypot: :title

  def create
    @user = User.new(user_params)
    @user.ip_address = request.remote_ip

    if user_params[:email] =~ /163\.com$/
      flash[:notice] = "Nothing to see here"
      redirect_to '/'

    elsif @user.save
      #flash[:notice] = "Most excellent!  You will hear from us soon."
      flash[:notice] = "Most excellent!  Make sure to register for our beta competition"

      # referer_tracking_after_create(@user)
      redirect_to '/game/beta_competition'
    else
      flash[:error] = "Totally bogus email address, bub..."
      redirect_to '/'
    end
  end

  def user_params
    params.require(:user).permit(:email)
  end
end