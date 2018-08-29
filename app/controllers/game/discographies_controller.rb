module Game
  class DiscographiesController < ApplicationController
    layout  'game'

    def index
      @selected = :disco
      @media = params[:media] ? params[:media].to_sym : :cassette
      @years = ['1980']

    end
  end
end