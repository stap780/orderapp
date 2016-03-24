class Enter < ActiveRecord::Base

has_many   :stocks, dependent: :destroy
has_many   :store_items, dependent: :destroy
has_many   :products, :through => :store_items
accepts_nested_attributes_for :store_items, reject_if: proc { |attributes| attributes['title'].blank? }, allow_destroy: true

validates  :number, uniqueness: true


end
