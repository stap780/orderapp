class CreateInvoiceListItems < ActiveRecord::Migration
  def change
    create_table :invoice_list_items do |t|
    	t.integer  :invoice_list_id
		t.integer  :product_id
		t.integer  :quantity
		t.string   :title
		t.decimal  :price,      precision: 8, scale: 2
		t.decimal  :sum,        precision: 8, scale: 2


      t.timestamps null: false
    end
  end
end
