class AddColumnInvoiceoutCheckToInvoiceList < ActiveRecord::Migration
  def change
  add_column :invoice_lists, :invoiceout_check, :boolean
  end
end
