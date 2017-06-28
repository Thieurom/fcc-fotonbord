class RemoveIndexFromBordenFoton < ActiveRecord::Migration[5.0]
  def change
    remove_index :borden_fotons, [:user_id, :foton_id]
  end
end
