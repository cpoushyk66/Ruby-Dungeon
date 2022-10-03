class AddCharacterTokensToUser3 < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :character_tokens, :integer, null: false, default: 0
  end
end
