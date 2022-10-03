class AddCharacterTokensToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :character_tokens, :integer
  end
end
