xml.instruct!
xml.offers do
  @advt_hidden.each do |product|
		 a = "true"
    xml.offer("available" => "#{a}", "id" => product.inid.to_s) do 
      xml.title product.title
      xml.url "http://www.teletri.ru/product_by_id/"+ product.inid.to_s
      xml.model product.title
			xml.description product.short_description
    end
  end
end