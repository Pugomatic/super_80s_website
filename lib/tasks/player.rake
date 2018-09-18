require 'fileutils'

namespace :player do
  desc 'Import the Excel file'
  task clear_all: :environment do
    Player.destroy_all
  end
end