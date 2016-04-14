class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.decimal :qtynew
      t.decimal :qtyused
      t.text :comment
      t.references :document, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
