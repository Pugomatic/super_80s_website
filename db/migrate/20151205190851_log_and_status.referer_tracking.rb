# This migration comes from referer_tracking (originally 20150424090312)
class LogAndStatus < ActiveRecord::Migration
  def change
    add_column :referer_trackings, :log, :text
    add_column :referer_trackings, :status, :string
  end
end
