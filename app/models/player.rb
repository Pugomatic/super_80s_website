class Player < ActiveRecord::Base

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
