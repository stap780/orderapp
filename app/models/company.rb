class Company < ActiveRecord::Base

has_many :invoices
has_many :invoice_lists
has_many :invoiceouts
has_many :purchase_invoices
has_many :purchase_lists

has_many :contragents
has_many :clients, :through => :contragents
accepts_nested_attributes_for :clients

validates :inn, uniqueness: true
validates :title, presence: true

	


	# def self.getcompany(params)
# 	searchinn = params["inn"]
# 	url = "https://dadata.ru/api/v2/suggest/party"
# 	
# 	res = RestClient.post url, { 'query'=> "#{searchinn}" }.to_json, :Authorization => "Token c06864b3c1082f24e05f15e674b38c30f906b427", :accept => "application/json" , :content_type => "application/json"
# 	
# 	h = JSON.parse(res)
# 	
# 	fulltitle = h["suggestions"][0]["data"]["name"]["full_with_opf"]
# 	uraddress = h["suggestions"][0]["data"]["address"]["value"]
# 	inn = h["suggestions"][0]["data"]["inn"]
# 	kpp = h["suggestions"][0]["data"]["kpp"]
# 	ogrn = h["suggestions"][0]["data"]["ogrn"] 
# 	okpo = h["suggestions"][0]["data"]["okpo"]
# 	title = h["suggestions"][0]["data"]["name"]["short"]
# 	
# 	@company = Company.new
# 	@company.update_attributes(:title => title, :fulltitle => fulltitle, :uraddress => uraddress, :inn => inn, :kpp => kpp, :ogrn => ogrn, :okpo => okpo )
# 	end

end
