class Level < ActiveRecord::Base
  belongs_to :world
  belongs_to :next_level, class_name: Level

  def label
    "#{world.year}.#{month}"
  end
end