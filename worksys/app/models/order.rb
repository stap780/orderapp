class Order < ActiveRecord::Base

has_many :order_lines
has_many :products, :through => :order_lines
accepts_nested_attributes_for :order_lines, reject_if: proc { |attributes| attributes['product_id'].blank? }, allow_destroy: true
	accepts_nested_attributes_for :products
	validates :order_number, uniqueness: true 


end
