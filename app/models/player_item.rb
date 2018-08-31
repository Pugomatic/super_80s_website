class PlayerItem < ActiveRecord::Base
  belongs_to :player
  belongs_to :culture_item
end
