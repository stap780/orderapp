class BankItem < ActiveRecord::Base
  belongs_to :bank
  belongs_to :invoice
  belongs_to :purchase_invoice
end
