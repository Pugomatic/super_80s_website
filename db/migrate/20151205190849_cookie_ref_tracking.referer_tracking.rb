# This migration comes from referer_tracking (originally 20131124175848)
class CookieRefTracking < ActiveRecord::Migration
  def up
    add_column :referer_trackings, :cookie_referer_url, :text
    add_column :referer_trackings, :cookie_first_url, :text
    add_column :referer_trackings, :cookie_time, :timestamp
    rename_column :referer_trackings, :first_url, :session_first_url
    rename_column :referer_trackings, :referer_url, :session_referer_url
  end

  def down
    remove_column :referer_trackings, :cookie_first_url
    remove_column :referer_trackings, :cookie_referer_url
    remove_column :referer_trackings, :cookie_time
    rename_column :referer_trackings, :session_first_url, :first_url
    rename_column :referer_trackings, :session_referer_url, :referer_url
  end
end