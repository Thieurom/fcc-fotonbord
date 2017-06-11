class CreateFotons < ActiveRecord::Migration[5.0]
  def change
    create_table :fotons do |t|
      t.string :source
      t.text :caption

      t.timestamps
    end
  end
end
