class CreatePrizes < ActiveRecord::Migration[4.2]
  def change
    create_table :prizes do |t|
      t.string :name
      t.integer :amount

      t.timestamps null: false
    end

    add_column :players, :prize_id, :integer
    add_column :players, :feedback, :text
  end
end
