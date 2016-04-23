# -*- encoding : utf-8 -*-
class Orderstatus < ActiveRecord::Base
  
  has_many :orders
  
  has_many :iorderstatuses
  has_many :iorders, through: :iorderstatuses
end
