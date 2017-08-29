class BetaTestersController < ApplicationController
  layout 'simple'

  def index
    if params[:code] == '19.84.1' && params[:email].present?
      BetaTester.create(email: params[:email], version: params[:code])
    end
  end
end