class ChangeCharacterIdToPloy < ActiveRecord::Migration[7.0]
  def change
    remove_column :equipment, :character_id
    add_reference :equipment, :wearer, polymorphic: true, index: true
  end
end
