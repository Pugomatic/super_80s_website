class Player < ActiveRecord::Base

  def self.award
    players = where(prized_at: nil, drawn_at: nil).to_a
    return nil unless players.size > 0

    winner = rand(players.size)
    players.each do |player|
      player.update_attribute :drawn_at, Time.now
    end

    players[winner].update_attribute :prized_at, Time.now

    players[winner]
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
