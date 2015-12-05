class Admin::EmailController < Comfy::Admin::Cms::BaseController
  def index
    @users = User.all
  end
end