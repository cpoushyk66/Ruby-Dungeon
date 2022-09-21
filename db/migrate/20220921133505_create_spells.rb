class CreateSpells < ActiveRecord::Migration[7.0]
  def change
    create_table :spells do |t|
      t.string :name, null: false
      t.integer :value, null: false, default: 0
      t.integer :mp_cost, null: false, default: 0
      t.string :effect, null: false
      t.string :flavor_text, null: false, default: "That sure is a spell!"
      t.string :school, null: false

      t.timestamps
    end
  end
end
