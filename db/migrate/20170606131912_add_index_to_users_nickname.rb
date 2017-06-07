class AddIndexToUsersNickname < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :nickname
  end
end
