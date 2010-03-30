class IssueMailer < ActionMailer::Base
  default :from => "soporte@xendacentral.com"
  
  def issue_sent(receipter)
    mail(:to=>receipter.email, :subject=> "Incidencia reportada")
  end
  
end
