class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Most excellent!  You will hear from us soon."
      referer_tracking_after_create(@user)

      begin
        gibbon = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
        gibbon.timeout = 10
        gibbon.lists(Rails.application.secrets.mailchimp_list_id).members.create(body: {email_address: @user.email, status: "subscribed"})
      rescue Gibbon::MailChimpError => mce
        logger.error "MailChimp Subscribe failed with mail chimp error: #{mce.title} #{mce.detail} #{mce.body} #{mce.status_code}"
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