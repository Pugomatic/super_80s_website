class UpdateItemDescriptions < ActiveRecord::Migration
  def change
    require 'rake'
    Rake::Task['data:update'].invoke
    Rake::Task['data:stats'].invoke
  end
end
