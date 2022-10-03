class RenameEquipmentItemIdToPocketId < ActiveRecord::Migration[7.0]
  def change
    rename_column :equipment, :item_id, :pocket_id
  end
end
