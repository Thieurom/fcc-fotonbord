class AddIndexToLikes < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, [:user_id, :foton_id], unique: true
  end
end
