class PurchaseList < ActiveRecord::Base

belongs_to :company
belongs_to :purchase_invoice
has_many   :stocks, dependent: :destroy
has_one    :purchase_invoice_in, dependent: :destroy
accepts_nested_attributes_for :purchase_invoice_in , reject_if: proc { |attributes| attributes['number'].blank? }, allow_destroy: true

has_many   :purchase_list_items, dependent: :destroy
has_many   :products, :through => :purchase_list_items
accepts_nested_attributes_for :purchase_list_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 
validates :number, uniqueness: { scope: [:company_id] }
validates :date, presence: true

end
