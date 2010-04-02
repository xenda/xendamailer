class IssueMailer < ActionMailer::Base
  default :from => "soporte@xendacentral.com"
  
  def issue_sent(receipter,content)
    @message = content
    mail(:to=>receipter.email, :subject=> "Incidencia reportada")
  end
  
  def issue_received(sender,receipter,subject,code)
    @title = subject
    @sender = sender
    @date = Time.zone.now
    @code = code || "123ABC".split("").shuffle.join
    mail(:to=>sender, :subject=> "[XendaSupport] Incidencia recibida con código #{@code}")
  end
  
  def issue_receive(sender, subject, code, pivotal_issue_url)
    @sender = sender
    @title = subject
    @code = code
    @pivotal_issue_url = pivotal_issue_url
    mail(:to=>"alvaro@xendacentral.com", :subject=>"[XendaSupport] Incidencia #{@code} recibida de #{@sender}")
  end
  
end
