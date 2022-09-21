class CreateEnemies < ActiveRecord::Migration[7.0]
  def change
    create_table :enemies do |t|
      t.string :name, null: false
      t.string :race, null: false
      t.integer :level, null: false, default: 1
      t.string :klass, null: false
      t.integer :strength, null: false, default: 0
      t.integer :dexterity, null: false, default: 0
      t.integer :wisdom, null: false, default: 0
      t.integer :constitution, null: false, default: 0
      t.integer :intelligence, null: false, default: 0
      t.integer :charisma, null: false, default: 0
      t.integer :rarity, null: false, default: 0
      t.integer :gold, null: false, default: 0

      t.timestamps
    end
  end
end
