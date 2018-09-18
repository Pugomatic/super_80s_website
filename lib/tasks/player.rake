require 'fileutils'

namespace :player do
  desc 'Import the Excel file'
  task clear_all: :environment do
    Player.destroy_all
    PlayerAchievement.destroy_all
    PlayerItem.destroy_all
    PlayerTotal.destroy_all
    PlayerWorld.destroy_all
    PlayerLevel.destroy_all
  end
end