class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :item_type, null: false
      t.integer :bonus, null: false, default: 0
      t.string :bonus_type, null: false
      t.integer :value, null: false, default: 0
      t.integer :rarity, null: false, default: 0
      t.string :class_restriction, null: false, default: ""
      t.boolean :sellable, null: false, default: true
      t.string :flavor_text, null: false, default: "An item for sure!"

      t.timestamps
    end
  end
end
