class AddColumnIorderIdToInvoices < ActiveRecord::Migration
  def change
  add_column :invoices, :iorder_id, :integer
  end
end
