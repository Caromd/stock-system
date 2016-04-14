class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :code
      t.date :docdate
      t.text :comment
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
