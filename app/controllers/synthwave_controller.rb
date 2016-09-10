class SynthwaveController < ApplicationController
  def index
    @name = Words.generate
  end
end