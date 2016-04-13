class ChecklistMailer < ActionMailer::Base
  default from: "no-reply@dss.ucdavis.edu"

  def send_email(message, recipient, subject)
    @message = message
    mail(:subject => subject, :to => recipient).deliver
  end

  def send_abandoned(checklist, recipient)
    require 'yaml'
    conf = YAML.load_file("config/settings.yml")
    @checklist = checklist
    @host = conf['HOST']
    mail(:subject => "Abandoned Checklist", :to => recipient).deliver
  end
end
