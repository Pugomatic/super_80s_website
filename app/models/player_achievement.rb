class PlayerAchievement < ActiveRecord::Base
  belongs_to :player
  belongs_to :achievement
  belongs_to :level_awarded, class_name: Level

  validates :player_id, presence: true
  validates :achievement_id, presence: true, uniqueness: {scope: :player_id}
end
