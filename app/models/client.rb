class Client < ActiveRecord::Base

	has_many :iorders
	has_many :invoices
	
	has_many :contragents
	has_many :companies, :through => :contragents
	accepts_nested_attributes_for :companies , reject_if: proc { |attributes| attributes['inn'].blank? }, allow_destroy: true
	
	has_many :invoices
	validates :phone, uniqueness: true


	
end
