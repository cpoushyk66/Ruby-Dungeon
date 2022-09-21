class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false, default: "Adventurer"
      t.string :title, null: false, default: ""
      t.integer :xp, null: false, default: 0
      t.string :klass, null: false, default: "Warrior"
      t.integer :strength, null: false, default: 0
      t.integer :dexterity, null: false, default: 0
      t.integer :wisdom, null: false, default: 0
      t.integer :constitution, null: false, default: 0
      t.integer :intelligence, null: false, default: 0
      t.integer :charisma, null: false, default: 0
      t.integer :gold, null: false, default: 0
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
