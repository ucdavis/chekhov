require 'rake'

namespace :checklist do
  desc 'Send email based on checklist status'
  task :warn do
    # Compare the created_at of all checklist with today's date
    Checklist.where('created_at >=?', 1.week.ago).where("finished IS NULL").find_each do |checklist|
      user = User.where(:id => checklist.user_id).take

      ChecklistMailer.send_email(message, user.email, 'Abandoned Checklist')
    end
    # if a checklist has been going on for more than a week, then send an email to creator
  end
end
