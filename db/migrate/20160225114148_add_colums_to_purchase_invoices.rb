class AddColumsToPurchaseInvoices < ActiveRecord::Migration
  def change
  add_column :purchase_invoices, :purchase_list_check, :boolean
  add_column :purchase_invoices, :status, :string
  end
end
