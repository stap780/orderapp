class Stock < ActiveRecord::Base
	
	#validates :invoice_list_id, uniqueness: { scope: [:product_id] } # не помню зачем сделал валидацию на уникальность айди продукта
	belongs_to :product
	belongs_to :invoice_list
	belongs_to :purchase_list
	belongs_to :store
	belongs_to :loss
	belongs_to :enter


end
