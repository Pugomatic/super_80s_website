class AchievementItem < ApplicationRecord
  belongs_to  :achievement
  belongs_to  :culture_item
end
