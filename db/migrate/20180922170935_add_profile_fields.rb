class AddProfileFields < ActiveRecord::Migration[5.2]
  def change
    add_column  :players, :internal, :boolean, default: false
    add_column  :players, :public, :boolean, default: false
    add_column  :players, :leader, :boolean, default: true
  end
end
