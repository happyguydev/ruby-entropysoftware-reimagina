class ProccessInstrumentMailer < ApplicationMailer

	def send_answer_report(file_name, current_user)
		attachments["#{file_name}.pdf"] = File.read("public/pdfs/#{file_name}.pdf")
		mail(to: "#{current_user.email}", subject: 'Su informe de resultados.')
	end
end
