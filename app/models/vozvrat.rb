class Vozvrat < ActiveRecord::Base
	
	belongs_to :invoice_list
	
	validates  :number, uniqueness: true
end
