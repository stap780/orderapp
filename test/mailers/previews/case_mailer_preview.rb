# Preview all emails at http://localhost:3000/rails/mailers/case_mailer
class CaseMailerPreview < ActionMailer::Preview
	
	def new_case
		cs = Case.last
		CaseMailer.new_case(cs)
	end

end
