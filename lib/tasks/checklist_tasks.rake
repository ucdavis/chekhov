require 'rake'

namespace :checklist do
  desc 'Send email based on checklist status'
  task :warn => :environment do
    # Compare the created_at of all checklist with today's date
    Authorization.ignore_access_control(true)
    Checklist.where('updated_at <=?', 1.week.ago).where("finished IS NULL").where(archived: [false, nil]).find_each do |checklist|
      user = User.where(:id => checklist.user_id).take
      ChecklistMailer.send_abandoned(checklist, user.email)
    end
    Authorization.ignore_access_control(false)
    # if a checklist has been going on for more than a week, then send an email to creator
  end
end
