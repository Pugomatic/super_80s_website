class ApplicationController < ActionController::Base
  include RefererTracking::ControllerAddons

  protect_from_forgery with: :exception

end
