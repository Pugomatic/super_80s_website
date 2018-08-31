class Player < ActiveRecord::Base
  belongs_to :current_level, class_name: Level
  belongs_to :top_completed_level, class_name: Level
end
