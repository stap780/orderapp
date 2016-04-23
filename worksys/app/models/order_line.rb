class OrderLine < ActiveRecord::Base

belongs_to :order
belongs_to :product

accepts_nested_attributes_for :product
	accepts_nested_attributes_for :order

end