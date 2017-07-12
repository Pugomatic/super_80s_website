class Player < ActiveRecord::Base
  belongs_to  :prize

  validates   :name, presence: true
  validates   :email, presence: true, uniqueness: true

  ODDS = 3

  def award!
    prize = nil

    transaction do
      prizes = Prize.where('amount > 0')

      update_attribute :drawn_at, Time.now

      if rand(ODDS) == 0
        prize = prizes.to_a[rand(prizes.count)]
        update_attributes prized_at: Time.now, prize_id: prize.id
        prize.update_attribute :amount, prize.amount - 1
      end
    end

    prize ? self : nil
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
