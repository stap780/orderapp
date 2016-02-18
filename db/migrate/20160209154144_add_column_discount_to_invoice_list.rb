class AddColumnDiscountToInvoiceList < ActiveRecord::Migration
  def change
  add_column :invoice_lists, :discount, :decimal,           precision: 8, scale: 2
  end
end
