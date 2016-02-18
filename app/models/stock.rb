class Stock < ActiveRecord::Base
	
	validates :invoice_list_id, uniqueness: { scope: [:product_id] }
	belongs_to :product
	belongs_to :invoice_list
	#belongs_to :purshase_list

end
