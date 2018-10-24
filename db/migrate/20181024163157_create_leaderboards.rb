class CreateLeaderboards < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboards do |t|
      t.string :name
      t.string :stat
      t.string :label
      t.string :format

      t.timestamps
    end
  end
end
