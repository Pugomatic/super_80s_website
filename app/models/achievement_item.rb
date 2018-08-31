class AchievementItem < ActiveRecord::Base
  belongs_to  :achievement
  belongs_to  :culture_item
end
