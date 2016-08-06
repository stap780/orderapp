# -*- encoding : utf-8 -*-
InsalesApp::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  
  config.action_mailer.delivery_method = :smtp
  
  config.action_mailer.smtp_settings = {
	  address: "smtp.gmail.com",
	  port: 587,
	  domain: "teletri.ru",
	  authentication: "login",
	  enable_starttls_auto: true,
	  user_name: "advt@teletri.ru",
	  password: "advt@teletri.ru",
	  openssl_verify_mode: "none"
  } # и дал разрешение в gmail (advt) на доступ к аккаунту из непроверенных источников - https://www.google.com/settings/security/lesssecureapps - но помогло или нет не проверял - устал
  
  config.action_mailer.default_url_options = { host: "http://188.166.111.118:3000" }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.serve_static_files = false
  config.assets.compile = true
  config.assets.compress = false
  config.assets.debug = true

  # Expands the lines which load the assets
  #config.assets.debug = true
  config.eager_load = false
  
  #config.logger = Logger.new(STDOUT)
  #config.logger.level = Logger::ERROR
  
end
