class PurchaseInvoice < ActiveRecord::Base

belongs_to :company
has_many   :purchase_lists, dependent: :destroy
has_many   :purchase_invoice_items, dependent: :destroy
has_many   :products, :through => :purchase_invoice_items
accepts_nested_attributes_for :purchase_invoice_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 
validates :number, presence: true

delegate :title, to: :company, prefix: true, allow_nil: true

end