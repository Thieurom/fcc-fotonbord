class AddUniqueToBordenFotonIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :borden_fotons, [:user_id, :foton_id], unique: true
  end
end
