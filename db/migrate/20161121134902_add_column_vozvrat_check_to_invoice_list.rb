class AddColumnVozvratCheckToInvoiceList < ActiveRecord::Migration
  def change
  add_column :invoice_lists, :vozvrat_check, :boolean
  end
end
