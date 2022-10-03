class CreateEquipment < ActiveRecord::Migration[7.0]
  def change
    create_table :equipment do |t|
      t.integer :character_id
      t.integer :item_id
      t.string :equip_type, null: false

      t.timestamps
    end
  end
end
