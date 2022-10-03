class RemoveDarkModeUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :dark_mode
  end
end
