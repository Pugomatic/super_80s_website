require_relative 'boot'

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env)

module Website
  class Application < Rails::Application
    config.app_middleware.delete "ActiveRecord::ConnectionAdapters::ConnectionManagement"
  end
end
