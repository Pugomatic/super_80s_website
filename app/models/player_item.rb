class PlayerItem < ApplicationRecord
  belongs_to :player
  belongs_to :culture_item

  validates :player_id, presence: true
  validates :culture_item_id, presence: true, uniqueness: {scope: :player_id}

  delegate  :artist, to: :culture_item
  delegate  :dans_commentary, to: :culture_item
  delegate  :title, to: :culture_item
  delegate  :funny_title, to: :culture_item
  delegate  :uid, to: :culture_item
  delegate  :color, to: :culture_item
  delegate  :media, to: :culture_item
  delegate  :year, to: :culture_item
end
