# -*- encoding : utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base


protect_from_forgery with: :exception

	before_filter :set_user_language

	
	def set_user_language
	I18n.locale = current_user.language if !current_user.nil?
	end
  
  private
  def current_user
    User.where(id: session[:user_id]).first
  end
  helper_method :current_user
  
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
     end
  end

#Ниже то что было в заготовке Инсалес
 #  helper :all # include all helpers, all the time
#   protect_from_forgery # See ActionController::RequestForgeryProtection for details
#   before_filter :authentication, :configure_api
# 
#   protected
# 
#   def authentication
#     logout if enter_from_different_shop?
# 
#     if current_app and current_app.authorized?
#       return if @account = Account.find_by_insales_subdomain(current_app.shop)
#     end
# 
#     store_location
# 
#     if account_by_params
#       init_authorization account_by_params
#     else
#       redirect_to login_path
#     end
#   end
# 
#   def logout
#     reset_session
#   end
# 
#   def configure_api
#     current_app.configure_api
#   end
# 
#   def init_authorization account
#     session[:app] = MyApp.new(account.insales_subdomain, account.password)
# 
#     redirect_to session[:app].authorization_url 
#   end
# 
#   def store_location(path = nil)
#     session[:return_to] = path || request.fullpath
#   end
# 
#   def location
#     session[:return_to]
#   end
# 
#   def not_found
#     raise ActionController::RoutingError.new('Not Found')
#   end
# 
#   def enter_from_different_shop?
#     current_app and !params[:shop].blank? && params[:shop] != current_app.shop
#   end
# 
#   def account_by_params
#     @account ||= if params[:insales_id]
#       Account.find_by_insales_id(params[:insales_id])
#     else
#       Account.find_by_insales_subdomain(params[:shop])
#     end
#   end
# 
#   def current_app
#     session[:app]
#   end
end
