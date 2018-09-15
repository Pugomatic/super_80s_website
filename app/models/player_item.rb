class PlayerItem < ApplicationRecord
  belongs_to :player
  belongs_to :culture_item
end
