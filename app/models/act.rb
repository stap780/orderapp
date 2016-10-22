class Act < ActiveRecord::Base
	
	belongs_to :company
	
	delegate :title, to: :company, prefix: true, allow_nil: true

	
end
