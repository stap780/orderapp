# -*- encoding : utf-8 -*-
class Account < ActiveRecord::Base


  validates_presence_of :insales_id
  validates_presence_of :insales_subdomain
  validates_presence_of :password


def configure_api
InsalesApi::Base.configure MyApp.api_key , "http://worksys.myinsales.ru", password
end


end
