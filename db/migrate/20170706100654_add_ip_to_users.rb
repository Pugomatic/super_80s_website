class AddIpToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :ip_address, :string
  end
end
