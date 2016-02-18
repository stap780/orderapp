#encoding: utf-8
class Rrc < ActiveRecord::Base
	
	has_many :products
	
	validates :sku, uniqueness: true
	
	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |rrc|
        csv << rrc.attributes.values_at(*column_names)
      end
    end
  end

  
  def self.updateproduct

	  a = Mechanize.new { |agent| agent.user_agent_alias = "Windows IE 7" }
      a.cookie_jar.clear!  
    a.get("http://www.rrc.ru/catalog/")
    form = a.page.forms.last
    form.USER_LOGIN = "Панает.Эмексизов"
    form.USER_PASSWORD = "z9j08F6"
    form.submit
    
    cisco = a.page.link_with(:text => "VoIP").click
    @rrc = cisco.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end
    
    a.get("http://www.rrc.ru/catalog/")
   
   cisco = a.page.link_with(:text => "Коммутаторы").click
    
    @rrc = cisco.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end
    
    a.get("http://www.rrc.ru/catalog/")
  
    yealink = a.page.link_with(:text => "IP-телефоны").click
    @rrc = yealink.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end
    
    a.get("http://www.rrc.ru/catalog/")
  
    yealink = a.page.link_with(:text => "IP DECT-телефоны").click
    @rrc = yealink.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end
    
    
    a.get("http://www.rrc.ru/catalog/")
  
    yealink = a.page.link_with(:text => "Аксессуары для IP DECT-телефонов").click
    @rrc = yealink.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end
    
    a.get("http://www.rrc.ru/catalog/")
  
    yealink = a.page.link_with(:text => "Аксессуары для IP-телефонов").click
    @rrc = yealink.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end  
    
    a.get("http://www.rrc.ru/catalog/")
  
    yealink = a.page.link_with(:text => "Видеоконференцсвязь (ВКС)").click
    @rrc = yealink.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end
    
    a.get("http://www.rrc.ru/catalog/")
  
    yealink = a.page.link_with(:text => "IP-видеотелефоны").click
    @rrc = yealink.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end
    
    a.get("http://www.rrc.ru/catalog/")
  
    zyxel = a.page.link_with(:text => "Сетевое оборудование").click
    @rrc = zyxel.search("#x-product-items > table > tbody")   
    @rrc.each do |b|
      @rrcs = Rrc.where("sku = ?", b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",''))
      
      sku = b.css('tr:nth-child(1) > td:nth-child(1)').text.gsub(/[ \t\r\n\f ]/,'').gsub("Аналоги",'')
      title = b.css('tr:nth-child(1) > td.b-catalog-productName > a').text        
      quantity = b.css('tr:nth-child(1) > td:nth-child(4)').text.gsub(/[ \t\r\n\f]/,'')
        
        @rrcs.each do |b|
        b.update_attributes(:sku => sku, :title => title, :quantity => quantity)
        end
        
    end

  end



end
