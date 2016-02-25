# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

	def new
	end
	
	def create
	user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect_to root_url, notice: 'Logged in!'
		else
		  render :new
		end
	end
	
	def destroy
	session[:user_id] = nil
	redirect_to root_url, notice: 'Logged out!'
	end

# Ниже то что было в заготовке от Инсалес
  # skip_before_filter :authentication, :configure_api, :except => [:destroy]
#   layout 'login'
# 
#   def show
#     render :action => :new
#   end
# 
#   def create
#   
#     @shop = params[:shop]
#     if account_by_params
#       init_authorization account_by_params
#     else
#       flash.now[:error] = "Check store address (domain) now"
#       render :action => :new
#     end
#   end
# 
#   def autologin
#     if current_app and current_app.authorize params[:token]
#       #redirect_to root_path  
#       redirect_to location || root_path
#     else
#       redirect_to login_path
#     end
#   end
# 
#   def destroy
#     logout
#     redirect_to login_path
#   end
end
