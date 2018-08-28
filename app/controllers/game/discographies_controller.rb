module Game
  class DiscographiesController < ApplicationController
    layout  'game'

    def index
      @selected = :disco
      @memo = :cartridge
      @years = ['1980']
    end
  end
end