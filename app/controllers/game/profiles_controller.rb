module Game
  class ProfilesController < ApplicationController
    layout  'game'

    def index
      @selected = :profile
    end
  end
end