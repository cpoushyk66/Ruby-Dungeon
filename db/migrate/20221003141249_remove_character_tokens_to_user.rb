class RemoveCharacterTokensToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :character_tokens
  end
end
