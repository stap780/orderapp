class InvoiceListItem < ActiveRecord::Base

	
	belongs_to :product
	belongs_to :invoice_list



end
