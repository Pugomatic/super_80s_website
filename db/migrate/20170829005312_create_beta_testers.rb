class CreateBetaTesters < ActiveRecord::Migration[4.2]
  def change
    create_table :beta_testers do |t|
      t.text :email
      t.string :version
      t.boolean :installed
      t.integer :plays

      t.timestamps null: false
    end
  end
end
