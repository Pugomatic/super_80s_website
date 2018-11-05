class ApplicationController < ActionController::Base
  before_action :set_raven_context
  #include RefererTracking::ControllerAddons

  before_action   :set_user
  protect_from_forgery with: :exception

  def set_user
    @user = User.new
  end

  def after_sign_in_path_for(resource_or_scope)
    game_profiles_path
  end

  def after_sign_up_path_for(resource)
    game_leaderboards_controller
  end

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
