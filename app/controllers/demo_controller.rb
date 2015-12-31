class DemoController < ApplicationController
  http_basic_authenticate_with name: ENV['DEMO_USER'], password: ENV['DEMO_PASSWORD']

  def index
  end

  def unity3d
    send_file(Rails.root.join('private', 'web-demo.unity3d'))
  end
end