class InvoiceList < ActiveRecord::Base

belongs_to :client
belongs_to :company
belongs_to :invoice
has_many   :stocks

has_one    :invoiceout

has_many   :invoice_list_items
has_many   :products, :through => :invoice_list_items
accepts_nested_attributes_for :invoice_list_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 

validates  :number, uniqueness: true

delegate :title, to: :company, prefix: true, allow_nil: true

end
