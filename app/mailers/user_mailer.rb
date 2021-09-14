class UserMailer < ApplicationMailer

  def send_comparatives_report(current_user, file_path)
    #attachments["comparativo_pdf_report.pdf"] = open(file_path).read
    file_name = File.basename(file_path)
    file_name_clean = file_name.gsub("%20","_")    
    attachments[file_name_clean] = open(file_path).read
    mail(to: "#{current_user.email}", subject: 'Informe listo para descargar')
  end

end