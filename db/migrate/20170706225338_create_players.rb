class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.datetime  :prized_at
      t.datetime  :drawn_at
      t.string    :name
      t.string    :email, null: false
      t.boolean   :iphone
      t.boolean   :ipad
      t.boolean   :android
      t.boolean   :other

      t.timestamps null: false
    end
  end
end
