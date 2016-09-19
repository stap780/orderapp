class Invoice < ActiveRecord::Base

belongs_to :client
belongs_to :company
belongs_to :iorder
has_many   :invoice_lists, dependent: :destroy
has_many   :banks
has_many   :invoice_items, dependent: :destroy
has_many   :products, :through => :invoice_items
accepts_nested_attributes_for :invoice_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 

validates  :number, uniqueness: true

delegate :title, to: :company, prefix: true, allow_nil: true

end
