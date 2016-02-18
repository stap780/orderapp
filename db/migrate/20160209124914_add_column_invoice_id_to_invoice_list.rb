class AddColumnInvoiceIdToInvoiceList < ActiveRecord::Migration
  def change
  add_column :invoice_lists, :invoice_id, :integer
  end
end
