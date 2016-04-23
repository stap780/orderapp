# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  
  def flash_messages
    message_divs = []
    [:error, :notice].each do |key|
      next unless massage = flash[key]
      message_p = content_tag(:p, massage, :class => key)
      message_divs << content_tag(:div, message_p, :class=>"message")
    end
    flash.clear # Защита для того, чтобы не вывести flash дважды
    content_tag :div, message_divs.join(''), {:id => "flash_messages"}, false
  end

  def home_path
    # "http://#{account_domain}/admin/home"
  end

  def account_domain
    session[:shop] || @account.insales_subdomain
  end

  def app_name
    'Orderapp'
  end
  
  def link_to_add_fields(name, f, type)
  new_object = f.object.send "build_#{type}"
  id = "new_#{type}"
  fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
    render(type.to_s + "_fields", f: builder)
  end
  link_to(name, '#', class: "add_fields btn btn-default btn-sm", data: {id: id, fields: fields.gsub("\n", "")})
end
 
end
