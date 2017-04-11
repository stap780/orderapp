xml.instruct!
xml.offers do

  @advt_products.each do |product|
	  if product.quantity !=nil
	  if product.quantity > 0 
		 a = "true"
		 else
		 a = "false"
		 end 
		xml.offer("available" => "#{a}", "id" => product.inid.to_s) do 
			price = ((product.variants.first.price.to_f - (product.variants.first.price.to_f * 5 / 100).to_f)* Kur.last.dollar).round(0)
			desc = product.short_description + ' от ' + "#{price}"+'руб'
			xml.title product.title
			xml.url "http://www.teletri.ru/product_by_id/"+ product.inid.to_s+'?discount=discount5'
			xml.price "#{price}"
			xml.currencyId "RUR"
			xml.model product.title
			xml.description "#{desc}"
		end
		
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