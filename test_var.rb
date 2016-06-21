p = Product.where('ipmatika_id IS NOT NULL')
p.each do |p|
a = p.variants.where('product_option_id = 2').first # Ipmatika
if !a.nil?
a.supplier_id = p.ipmatika_id
a.save
else
p.variants.create(product_id: p.id, sku: p.sku, cost_price: p.cost_price, price: p.price, old_price: p.price, quantity: p.quantity, weight: 1, product_option_id: 2, supplier_id: p.ipmatika_id)
end
end


p = Product.where('homyproduct_id IS NOT NULL')
p.each do |p|
a = p.variants.where('product_option_id = 3').first # Премьер
if !a.nil?
a.supplier_id = p.homyproduct_id
a.save
else
p.variants.create(product_id: p.id, sku: p.sku, cost_price: p.cost_price, price: p.price, old_price: p.price, quantity: p.quantity, weight: 1, product_option_id: 3, supplier_id: p.homyproduct_id)
end
end

p = Product.where('emag_id IS NOT NULL')
p.each do |p|
a = p.variants.where('product_option_id = 4').first # Emag
if !a.nil?
a.supplier_id = p.emag_id
a.save
else
p.variants.create(product_id: p.id, sku: p.sku, cost_price: p.cost_price, price: p.price, old_price: p.price, quantity: p.quantity, weight: 1, product_option_id: 4, supplier_id: p.emag_id)
end
end



p = Product.where('rrc_id IS NOT NULL')
p.each do |p|
a = p.variants.where('product_option_id = 6').first # RRC
if !a.nil?
a.supplier_id = p.rrc_id
a.save
else
p.variants.create(product_id: p.id, sku: p.sku, cost_price: p.cost_price, price: p.price, old_price: p.price, quantity: p.quantity, weight: 1, product_option_id: 6, supplier_id: p.rrc_id)
end
end

p = Product.where('angel_id IS NOT NULL')
p.each do |p|
a = p.variants.where('product_option_id = 7').first # Angel
if !a.nil?
a.supplier_id = p.angel_id
a.save
else
p.variants.create(product_id: p.id, sku: p.sku, cost_price: p.cost_price, price: p.price, old_price: p.price, quantity: p.quantity, weight: 1, product_option_id: 7, supplier_id: p.angel_id)
end
end

p = Product.where('vimcom_id IS NOT NULL')
p.each do |p|
a = p.variants.where('product_option_id = 8').first # Vimcom
if !a.nil?
a.supplier_id = p.vimcom_id
a.save
else
p.variants.create(product_id: p.id, sku: p.sku, cost_price: p.cost_price, price: p.price, old_price: p.price, quantity: p.quantity, weight: 1, product_option_id: 8, supplier_id: p.vimcom_id)
end
end