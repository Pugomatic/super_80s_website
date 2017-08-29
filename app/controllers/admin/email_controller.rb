class Admin::EmailController < Comfy::Admin::Cms::BaseController
  def index
    if params[:beta_testers]
      @beta = false
      @users = User.all
    else
      @beta = true
      @users = BetaTester.alls
    end
  end
end