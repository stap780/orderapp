class CaseMailer < ApplicationMailer
	
def new_case(cs)
	@case = cs
		
	mail to: @case.client.email,
	     subject: "Заявка #{@case.number} на разработку в веб студии - ketago.com",
	     from: "info@ketago.com",
	     reply_to: "info@ketago.com"
end	

def notifier_case(cs)
		@case = cs
		
	mail to: "info@ketago.com",
	     cc: "zakaz@teletri.ru",
	     subject: "Поступила заявка #{@case.number} на разработку в веб студии - ketago.com",
	     from: "info@ketago.com",
	     reply_to: @case.client.email	
end
	
end
