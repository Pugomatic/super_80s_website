class LeaderboardPlayer < ApplicationRecord
  belongs_to :leaderboard
  belongs_to :player

  validates :player_id, uniqueness: {scope: :leaderboard_id}
end
