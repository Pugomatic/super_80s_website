class UpdateItemDescriptions < ActiveRecord::Migration[5.2]
  def change
    require 'rake'
    Rake::Task['data:update'].invoke
    Rake::Task['data:stats'].invoke
  end
end
