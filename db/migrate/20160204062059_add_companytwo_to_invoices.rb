class AddCompanytwoToInvoices < ActiveRecord::Migration
  def change
  add_column :invoices, :companytwo, :integer
  end
end
