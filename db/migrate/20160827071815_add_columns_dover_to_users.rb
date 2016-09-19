class AddColumnsDoverToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :doctype, :string
    add_column :users, :docseria, :string
    add_column :users, :docnumber, :string
    add_column :users, :dockem, :string
    add_column :users, :docdate, :date
  end
end
