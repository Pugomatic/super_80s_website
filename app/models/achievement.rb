class Achievement < ActiveRecord::Base
  LEVEL = 1
  YEAR = 2
  GAME = 3

  MULTI_ITEM_MINIMUM = 1
  MULTI_ITEM_EXACT = 2
  SINGLE_ITEM = 3
  TOTAL_COUNT_EXACT = 4
  TOTAL_COUNT_MINIMUM = 5
  FORMAT_COUNT_EXACT = 6
  FORMAT_COUNT_MINIMUM = 7
  SOLID_GOLD = 8
  ALL_ITEMS_FORMAT = 9
  ALL_ITEMS_TOTAL = 10
  N_OF_EACH_FORMAT = 11

  FONT_NORMAL = 1
  FONT_DISCO = 2
  FONT_MOVIE = 3
  FONT_METAL = 4
  FONT_PIXEL = 5

  FONT_WHITE = 1
  FONT_PINK = 2
  FONT_GOLD = 3
  FONT_BLUE = 4
  FONT_RED = 5
  FONT_YELLOW = 6
  FONT_GREY = 7
  FONT_GREEN = 8
  FONT_ORANGE = 9
  FONT_PURPLE = 10
  FONT_BROWN = 11

  has_many  :achievement_items
  has_many  :culture_items, through: :achievement_items
  has_many  :player_achievements
  has_many  :players, through: :player_achievements

  validates :name, presence: true
  validates :sort_name, presence: true
  validates :description, presence: true

  def self.with_items
    where(match_type: [MULTI_ITEM_MINIMUM, MULTI_ITEM_EXACT, SINGLE_ITEM])
  end
end