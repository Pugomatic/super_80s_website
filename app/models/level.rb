class Level < ApplicationRecord
  belongs_to :world
  belongs_to :next_level, class_name: 'Level'

  has_many   :player_levels

  def label
    "#{world.year}.#{month}"
  end
end
