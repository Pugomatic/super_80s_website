class Level < ApplicationRecord
  belongs_to :world
  belongs_to :next_level, class_name: 'Level'

  has_many   :player_levels

  delegate   :year, to: :world


  def label
    "#{year}.#{month}"
  end
end
