class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :players, :provider, :string
    add_column :players, :uid, :string
    add_column :players, :image, :text
    add_column :players, :fb_data, :text
    add_column :players, :handle, :string
    add_column :players, :pending, :boolean, default: false
  end
end
