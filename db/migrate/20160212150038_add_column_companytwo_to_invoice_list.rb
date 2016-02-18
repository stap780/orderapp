class AddColumnCompanytwoToInvoiceList < ActiveRecord::Migration
  def change
  add_column :invoice_lists, :companytwo, :integer
  end
end
