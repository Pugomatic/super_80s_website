class Admin::EmailController < Comfy::Admin::Cms::BaseController
  def index
    if params[:beta_testers]
      @beta = true
      @users = BetaTester.all
    else
      @beta = false
      @players = Player.all.order(created_at: :desc)
      @users = User.all.order(created_at: :desc).reject {|u| @players.map(&:email).include?(u.email) }
    end
  end
end