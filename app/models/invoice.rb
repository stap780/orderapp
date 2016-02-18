class Invoice < ActiveRecord::Base

belongs_to :client
belongs_to :company
has_one    :iorder
has_many   :invoice_lists

has_many   :invoice_items
has_many   :products, :through => :invoice_items
accepts_nested_attributes_for :invoice_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 

validates  :number, uniqueness: true
validates  :company, presence: true



end
