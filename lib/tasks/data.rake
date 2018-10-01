require 'fileutils'

namespace :data do
  desc 'Import the Excel file'
  task import: :environment do
    f = Struct.new(:original_filename, :path).new('data.xlsx', Rails.root.join('db', 'data.xlsx'))

    CultureItem.import(f)
  end

  desc 'Update data from the Excel file'
  task update: :environment do
    f = Struct.new(:original_filename, :path).new('data.xlsx', Rails.root.join('db', 'data.xlsx'))

    CultureItem.update!(f)
  end

  desc 'Show stats'
  task stats: :environment do
    CultureItem.stats
  end

  desc 'Give full collection to last player'
  task give_last_player_all: :environment do
    player = Player.last

    CultureItem.all.each do |item|
      unless player.player_items.culture_item_id == item.id
        PlayerItem.create(culture_item_id: item.id, player_id: player.id)
      end
    end

    Achievement.all.each do |a|
      unless player.player_achievements.achievement_id == a.id
        PlayerAchievement.create(achievement_id: a.id, player_id: player.id)
      end
    end
  end
end