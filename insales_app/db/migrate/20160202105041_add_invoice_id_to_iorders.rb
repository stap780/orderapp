class AddInvoiceIdToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :invoice_id, :integer
  end
end
