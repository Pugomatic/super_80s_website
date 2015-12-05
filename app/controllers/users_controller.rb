class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Most excellent!  You will hear from us soon."
      referer_tracking_after_create(@user)
    else
      flash[:error] = "Totally bogus email address, bub..."
    end


    redirect_to '/'
  end

  def user_params
    params.require(:user).permit(:email)
  end
end