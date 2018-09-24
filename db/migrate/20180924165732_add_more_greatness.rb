class AddMoreGreatness < ActiveRecord::Migration[5.2]
  def change
    add_column  :players, :tagline, :string
    add_column  :player_items, :favorite, :boolean
  end
end
