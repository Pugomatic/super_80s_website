class PlayerLevel < ActiveRecord::Base
  belongs_to :player
  belongs_to :world
  belongs_to :level

end
