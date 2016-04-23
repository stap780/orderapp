class AddColumnInvoiceListCheckToInvoice < ActiveRecord::Migration
  def change
  add_column :invoices, :invoice_list_check, :boolean
  end
end
