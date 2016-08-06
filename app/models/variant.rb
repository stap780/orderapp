class Variant < ActiveRecord::Base
	validates :product_option_id, :uniqueness => {:scope => [ :product_id]}
	validates :weight, presence: true
	validates :quantity, presence: true
	belongs_to :product
	belongs_to :product_option


	def self.addvariant #добавляем вариант в магазин и записываем variant_id в наш вариант(variant_inid) чтобы потом по варианту обновлять значения (цена, остаток и др)
	v = Variant.where('variant_inid IS NULL').order(:product_id)#'product_id = 14718 AND variant_inid IS NULL'
		v.each do |v|
			puts "#{(v.sku)}"
		     uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(v.product.inid)}.xml"
		    
 		       sendresponse = RestClient.put uri, "<product><variants-attributes ><variants-attribute><sku>#{(v.sku)}</sku><cost-price >#{(v.cost_price.to_f)}</cost-price><old-price >#{(v.old_price.to_f)}</old-price><price >#{(v.price.to_f)}</price><quantity>#{(v.quantity)}</quantity><weight>#{(v.weight)}</weight><options><option><option-name-id >#{(v.product_option.opt_name_inid)}</option-name-id><value>#{(v.product_option.title)}</value></option></options></variants-attribute></variants-attributes></product>", :accept => :xml, :content_type => "application/xml"
		       
		  
		  sleep(0.3)
		
		response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
		data = Nokogiri::XML(response)
		mypr = data.xpath("//variants/variant")
			mypr.each do |var|
			variant_inid = var.xpath("id").text
			option_id = var.xpath("option-values/option-value/id").text
				if option_id.present?
				a = ProductOption.find_by_opt_value_inid(option_id)
				product_option_id = a.id 
				end
			sku = var.xpath("sku").text
			cost_price = var.xpath("cost-price").text
			price = var.xpath("price").text
			old_price = var.xpath("old-price").text
			quantity = var.xpath("quantity").text
			weight = var.xpath("weight").text
			
			@variant = Variant.find_by_variant_inid("#{variant_inid}")
				if @variant.present?
				#@variant.update_attributes( :sku => sku, :cost_price => cost_price, :price => price, :old_price => old_price, :quantity => quantity, :weight => weight, :product_option_id => product_option_id)
				else
					if option_id = v.product_option.opt_value_inid
					@variant = Variant.where(:product_option_id => v.product_option.id, :product_id => v.product_id)
						@variant.each do |variant|
						variant.variant_inid = variant_inid
						variant.save
						end
					end
				end
			end
		
		end
	end

def self.updateqt
# 	v = Variant.order(:product_id)
# 		v.each do |v|
# 		     uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(v.product_id)}.xml"
# # 		     uri = "http://a2e2ed5ba6560944845dbf38f2223298:0e734e3c93ca9795f87313c83c5ebbcf@worksys.myinsales.ru/admin/products/#{(v.product_id)}/variants/#{(v.variant_inid)}.xml"
# 		    begin
# #  		       response = RestClient.put uri, "<variant><cost-price >#{(v.cost_price.to_f)}</cost-price><old-price >#{(v.old_price.to_f)}</old-price><price >#{(v.price.to_f)}</price><quantity>#{(v.quantity)}</quantity><weight>#{(v.weight)}</weight></variant>", :accept => :xml, :content_type => "application/xml"
#  		       
#  		       response = RestClient.put uri, "<product><variants-attributes ><variants-attribute><sku>#{(v.sku)}</sku><cost-price >#{(v.cost_price.to_f)}</cost-price><old-price >#{(v.old_price.to_f)}</old-price><price >#{(v.price.to_f)}</price><quantity>#{(v.quantity)}</quantity><weight>#{(v.weight)}</weight><options><option><option-name-id >#{(v.product_option.opt_name_inid)}</option-name-id><value>#{(v.product_option.title)}</value></option></options></variants-attribute></variants-attributes></product>", :accept => :xml, :content_type => "application/xml"
#  		    sleep(0.3)   		       
# # 			if response.code == 200
# # 			puts 'good'
# # 			sleep(0.3)
# # 			end	  
# 		  rescue => e
#  			if e.response.code == 503
# 	 		puts "sleep now"
# 	 		puts "#{(v.sku)} - #{(v.product_id)}"
# 	 		sleep(1.minutes)
# 	 		end	
# 		
# 		end
# end
end


end