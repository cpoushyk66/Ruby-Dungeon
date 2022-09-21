class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :image, null: false
      t.boolean :dark_mode, null: false, default: true

      t.timestamps
    end
  end
end
