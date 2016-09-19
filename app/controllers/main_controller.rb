# -*- encoding : utf-8 -*-
class MainController < ApplicationController

before_action :authorize
	
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

  def index

  end
  
end
