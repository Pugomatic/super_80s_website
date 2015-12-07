class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Most excellent!  You will hear from us soon."
      referer_tracking_after_create(@user)

      begin
        gibbon = Gibbon::API.new
        gibbon.lists(Rails.application.secrets.mailchimp_list_id).members.create(body: {email_address: @user.email})
      rescue Gibbon::MailChimpError => mce
        logger.error "MailChimp Subscribe failed with mail chimp error: #{mce.message}"
      rescue Exception => e
        logger.error "MailChimp Subscribe failed with other error: #{e.message}"
      end
    else
      flash[:error] = "Totally bogus email address, bub..."
    end


    redirect_to '/'
  end

  def user_params
    params.require(:user).permit(:email)
  end
end