class CreateMainHands < ActiveRecord::Migration[7.0]
  def change
    create_table :main_hands do |t|
      t.integer :character_id
      t.integer :item_id

      t.timestamps
    end
  end
end
