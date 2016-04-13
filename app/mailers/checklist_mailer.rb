class ChecklistMailer < ActionMailer::Base
  default from: "no-reply@dss.ucdavis.edu"

  def send_email(message, recipient, subject)
    @message = message
    mail(:subject => subject, :to => recipient).deliver
  end

  def send_abandoned(checklist, recipient)
    @checklist = checklist
    @host = Rails.application.routes.default_url_options[:host]
    mail(:subject => "Abandoned Checklist", :to => recipient).deliver
  end
end
