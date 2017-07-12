class PlayersController < ApplicationController
  layout 'simple'

  invisible_captcha only: [:create], honeypot: :subtitle

  def index
    @player = Player.new
    @players = Player.order(created_at: :desc)
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      @winner = @player.award!
    else
      flash.now[:error] = @player.errors.full_messages.join(', ')
    end

    @player = Player.new

    @players = Player.order(created_at: :desc)

    render :index
  end

  def player_params
    params.require(:player).permit(:name, :email, :iphone, :ipad, :android, :other, :feedback)
  end
end