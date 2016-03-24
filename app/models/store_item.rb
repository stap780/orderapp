class StoreItem < ActiveRecord::Base

belongs_to :product
belongs_to :loss
belongs_to :enter

end
