class Dover < ActiveRecord::Base
	
	belongs_to :company
	belongs_to :user
	has_many :dover_items, dependent: :destroy
	has_many   :products, :through => :dover_items
  accepts_nested_attributes_for :dover_items, allow_destroy: true #, reject_if: proc { |attributes| attributes['dover_id'].blank? }
  validates :number, presence: true	
  
  delegate :title, to: :company, prefix: true, allow_nil: true

  
end
