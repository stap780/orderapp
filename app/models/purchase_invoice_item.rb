class PurchaseInvoiceItem < ActiveRecord::Base

	belongs_to :product
	belongs_to :purchase_invoice


end
