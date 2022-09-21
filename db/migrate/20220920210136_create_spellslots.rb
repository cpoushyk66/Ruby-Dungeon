class CreateSpellslots < ActiveRecord::Migration[7.0]
  def change
    create_table :spellslots do |t|
      t.integer :spell_id, null: false
      t.references :caster, null: false, polymorphic: true

      t.timestamps
    end
  end
end
