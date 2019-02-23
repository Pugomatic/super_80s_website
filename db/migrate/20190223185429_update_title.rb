class UpdateTitle < ActiveRecord::Migration[5.2]
  def change
    Level.find_by(name: 'Kablam!').update_attribute(:name, 'Boombox Drop')
  end
end
