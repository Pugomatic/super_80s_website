class PlayerItem < ApplicationRecord
  belongs_to :player
  belongs_to :culture_item

  validates :player_id, presence: true
  validates :culture_item_id, presence: true, uniqueness: {scope: :player_id}
end
