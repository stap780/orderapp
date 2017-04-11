class InvoiceList < ActiveRecord::Base

belongs_to :client
belongs_to :company
belongs_to :invoice
has_many   :stocks, dependent: :destroy

has_one    :invoiceout, dependent: :destroy
has_one    :vozvrat, dependent: :destroy

has_many   :invoice_list_items, dependent: :destroy
has_many   :products, :through => :invoice_list_items
accepts_nested_attributes_for :invoice_list_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 

validates  :number, uniqueness: true
validates_presence_of :date

delegate :title, to: :company, prefix: true, allow_nil: true

end
