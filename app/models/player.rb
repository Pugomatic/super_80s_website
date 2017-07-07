class Player < ActiveRecord::Base
  belongs_to  :prize

  def self.award
    players = where(prized_at: nil, drawn_at: nil).to_a
    prizes = Prize.where('amount > 0')
    winner = nil

    return nil unless players.size > 0 && prizes.size > 0

    transaction do
      pick = rand(players.size)
      prize = prizes.to_a[rand(prizes.count)]
      players.each do |player|
        player.update_attribute :drawn_at, Time.now
      end

      players[pick].update_attributes prized_at: Time.now, prize_id: prize.id
      prize.update_attribute :amount, prize.amount - 1
      winner = players[pick].reload
    end

    winner
  end

  def style
    if prized_at
      'prized'
    elsif drawn_at
      'drawn'
    end
  end

  def icon
    if prized_at
      'star'
    elsif drawn_at
      ''
    else
      'ticket'
    end
  end
end
