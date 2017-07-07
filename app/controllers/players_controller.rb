class PlayersController < ApplicationController
  layout 'simple'

  def index
    @player = Player.new
    @players = Player.order(created_at: :desc)

    if Player.where(drawn_at: nil).count >= 5
      @winner = Player.award
    end
  end

  def award
    @winner = Player.award

    index

    render :index
  end

  def create
    Player.create!(player_params)

    redirect_to players_path
  end

  def player_params
    params.require(:player).permit(:name, :email, :iphone, :ipad, :android, :other, :feedback)
  end
end