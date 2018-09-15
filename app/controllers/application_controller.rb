class ApplicationController < ActionController::Base
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
    game_profiles_path
  end
end
