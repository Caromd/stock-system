class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :active, :is_active
  end
end
