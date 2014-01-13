class ChecklistMailer < ActionMailer::Base
  default from: "no-reply@dss.ucdavis.edu"
  
  def send_email(message, recipient, subject)
    @message = message
    mail(:subject => subject, :to => recipient)
  end
end
