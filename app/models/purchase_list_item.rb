class PurchaseListItem < ActiveRecord::Base

	belongs_to :product
	belongs_to :purchase_list


end
