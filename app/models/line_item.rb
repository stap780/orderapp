class LineItem < ActiveRecord::Base

	#attr_accessible :iorder_id, :product_id, :quantitiy

	belongs_to :iorder
	belongs_to :product
	belongs_to :invoice
	accepts_nested_attributes_for :product
	accepts_nested_attributes_for :iorder
	accepts_nested_attributes_for :invoice
	
	
end
