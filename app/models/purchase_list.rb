class PurchaseList < ActiveRecord::Base

belongs_to :company
belongs_to :purchase_invoice
has_many   :stocks

has_many   :purchase_list_items
has_many   :products, :through => :purchase_list_items
accepts_nested_attributes_for :purchase_list_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 
validates :number, uniqueness: true

end
