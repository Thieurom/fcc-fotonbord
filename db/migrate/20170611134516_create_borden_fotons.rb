class CreateBordenFotons < ActiveRecord::Migration[5.0]
  def change
    create_table :borden_fotons do |t|
      t.integer :user_id
      t.integer :foton_id

      t.timestamps
    end

    add_index :borden_fotons, [:user_id, :foton_id]
  end
end
