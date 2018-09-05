class PlayerLevel < ActiveRecord::Base
  belongs_to :player
  belongs_to :world
  belongs_to :level

  before_validation :set_defaults, on: :create

  private

  def set_defaults
    self.world_id = level.world_id
  end
end
