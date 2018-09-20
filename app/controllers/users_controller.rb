class UsersController < ApplicationController
  invisible_captcha only: [:create], honeypot: :title

  def create
    @user = User.new(user_params)
    @user.ip_address = request.remote_ip

    if user_params[:email] =~ /163\.com$/
      flash[:notice] = "Nothing to see here"
    elsif @user.save
      flash[:notice] = "Most excellent!  You will hear from us soon."
      # referer_tracking_after_create(@user)
    else
      flash[:error] = "Totally bogus email address, bub..."
    end

    redirect_to '/'
  end

  def user_params
    params.require(:user).permit(:email)
  end
end