# This migration comes from referer_tracking (originally 20140525105549)
class InfosHash < ActiveRecord::Migration
  def up
    add_column :referer_trackings, :infos_session, :text
    add_column :referer_trackings, :infos_request, :text
  end

  def down
    remove_column :referer_trackings, :infos_session
    remove_column :referer_trackings, :infos_request
  end
end
