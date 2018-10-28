class LeaderboardEntry < ApplicationRecord
  belongs_to  :leaderboard
  belongs_to  :player
  belongs_to  :level #optional

  validates :leaderboard, presence: true
  validates :player, uniqueness: true, presence: true

end