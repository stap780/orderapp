class Iorderstatus < ActiveRecord::Base
  #эта модель нужна для соединения таблицы(модели)  iorder с таблицей orderstatus
  belongs_to :iorder
  belongs_to :orderstatus
  
end
