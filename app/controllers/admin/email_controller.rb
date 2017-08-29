class Admin::EmailController < Comfy::Admin::Cms::BaseController
  def index
    if params[:beta_testers]
      @beta = true
      @users = BetaTester.all
    else
      @beta = false
      @users = User.all
    end
  end
end