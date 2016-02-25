class AddColumnPurchaseInvoiceIdToPurchaseList < ActiveRecord::Migration
  def change
  add_column :purchase_lists, :purchase_invoice_id, :integer
  end
end
