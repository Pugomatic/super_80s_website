class PlayerAchievement < ActiveRecord::Base
  belongs_to :player
  belongs_to :achievement
  belongs_to :level_awarded, class_name: Level
end
