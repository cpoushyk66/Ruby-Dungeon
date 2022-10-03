class AddLevelToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :level, :integer, default: 0
  end
end
