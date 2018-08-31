require 'fileutils'

namespace :data do
  desc 'Import the Excel file'
  task import: :environment do
    f = Struct.new(:original_filename, :path).new('data.xlsx', Rails.root.join('db', 'data.xlsx'))

    CultureItem.import(f)
  end

  desc 'Show stats'
  task stats: :environment do
    CultureItem.stats
  end
end