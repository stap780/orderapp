class Store < ActiveRecord::Base

has_many   :products
has_many   :stocks
accepts_nested_attributes_for :stocks # , reject_if: proc { |attributes| attributes['number'].blank? }, allow_destroy: true
has_many   :purchase_lists, :through => :stocks
has_many   :invoice_lists, :through => :stocks

validates :title, uniqueness: true


end
