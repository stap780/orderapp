class DoverItem < ActiveRecord::Base
	
	belongs_to :dover
	belongs_to :product
	validates :product_id, uniqueness: { scope: [:dover_id] }

	delegate :title, to: :product, prefix: true, allow_nil: true

	
	
	
end
