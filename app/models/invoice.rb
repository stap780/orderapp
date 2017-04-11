class Invoice < ActiveRecord::Base

belongs_to :client
belongs_to :company
belongs_to :iorder
has_many   :invoice_lists, dependent: :destroy
has_many 	 :bank_items
has_many   :banks, through: :bank_items
has_many   :invoice_items, dependent: :destroy
has_many   :products, :through => :invoice_items
accepts_nested_attributes_for :invoice_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true 

validates  :number, uniqueness: true

delegate :title, :title=, to: :company, prefix: true, allow_nil: true

def number_sum
	"#{number} Сумма #{total_price} руб от #{date.strftime("%d / %m / %Y")}"
	end

end
