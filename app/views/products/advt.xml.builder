xml.instruct!
xml.offers do

  @advt_products.each do |product|
	  #puts product.sku
	  if product.quantity > 0
		 a = "true"
		 else
		 a = "false"
		 end 
		xml.offer("available" => "#{a}", "id" => product.inid.to_s) do 
			xml.title product.title
			xml.url "http://www.teletri.ru/product_by_id/"+ product.inid.to_s
	    
		
	    price = (product.variants.last.price.to_f * @kurs).round(0) 
	    
			xml.price "#{price}"
			xml.currencyId "RUR"
			xml.model product.title
			xml.description product.short_description
		end
#       xml.comments do
#         post.comments.each do |comment|
#           xml.comment do
#             xml.body comment.body
#           end
#         end
#       end
  end
end