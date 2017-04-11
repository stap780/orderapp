class AddColumnPurchaseInvoiceIdToBank < ActiveRecord::Migration
  def change
  add_column :banks, :purchase_invoice_id, :integer
  end
end
