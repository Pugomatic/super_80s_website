class Level < ApplicationRecord
  belongs_to :world
  belongs_to :next_level, class_name: 'Level'

  has_many   :player_levels

  delegate   :year, to: :world

  def label
    "#{year}.#{month}"
  end

  def minigame?
    level_type == 2
  end

  def boss?
    level_type == 1
  end
end
