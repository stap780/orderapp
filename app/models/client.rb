class Client < ActiveRecord::Base

	has_many :iorders
	has_many :invoices
	
	has_many :contragents
	has_many :companies, :through => :contragents
	accepts_nested_attributes_for :companies , reject_if: proc { |attributes| attributes['inn'].blank? }, allow_destroy: true
	
	has_many :invoices
	validates :phone, uniqueness: true

	def client_iorder_name_surname #это для автокоплита - чтобы подставлялось имя и фамилия при подборе
    "#{self.name} #{self.surname}"
	end
	
	def to_label
    "#{self.name} #{self.surname}" #это для симпл-форм ассоциации - чтобы подставлялось имя и фамилия при выборе
	end
	
end
