class AddSuspectToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :is_suspect, :boolean
  end
end
