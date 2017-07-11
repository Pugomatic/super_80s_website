class AddSuspectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_suspect, :boolean
  end
end
