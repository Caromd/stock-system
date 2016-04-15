class AddLocationToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :location, index: true, foreign_key: true
  end
end
