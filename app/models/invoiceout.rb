class Invoiceout < ActiveRecord::Base

belongs_to :company
belongs_to :invoice_list

validates  :number, uniqueness: true

end
