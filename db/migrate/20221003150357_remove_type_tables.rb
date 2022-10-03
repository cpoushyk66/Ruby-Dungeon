class RemoveTypeTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :helms
    drop_table :chestplates
    drop_table :leggings
    drop_table :boots
    drop_table :main_hands
    drop_table :off_hands
  end
end
