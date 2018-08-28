module Game
  class DiscographiesController < ApplicationController
    layout  'game'

    def index
      @selected = :disco
    end
  end
end