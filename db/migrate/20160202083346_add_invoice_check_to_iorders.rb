class AddInvoiceCheckToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :invoice_check, :boolean
  end
end
