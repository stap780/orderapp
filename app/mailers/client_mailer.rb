class ClientMailer < ApplicationMailer
	default from: "advt@teletri.ru"
	layout 'client_mailer'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_mailer.advt_notification.subject
  #
  def advt_notification(client)
	  client = client
    @greeting = "Hi"

    mail to: client.email
  end
end
