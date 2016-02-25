class AddColumnsToPurchaseList < ActiveRecord::Migration
  def change
    add_column :purchase_lists, :purchase_invoicein_check, :boolean
  add_column :purchase_lists, :status, :string

  end
end
