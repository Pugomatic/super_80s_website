class ApplicationController < ActionController::Base
  include RefererTracking::ControllerAddons

  before_action   :set_user
  protect_from_forgery with: :exception

  def set_user
    @user = User.new
  end
end
