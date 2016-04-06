class ChecklistMailer < ActionMailer::Base
  default from: "no-reply@dss.ucdavis.edu"

  def send_email(message, recipient, subject)
    @message = message
    mail(:subject => subject, :to => recipient)
  end

  def send_abandoned(checklist, recipient)
    @checklist = checklist
    mail(:subject => "Abandoned Checklist", :to => recipient)
  end
end
