class UpdateArchivedInChecklists < ActiveRecord::Migration
    def change
        Authorization.ignore_access_control(true)
        Checklist.find_each do |checklist|
          if checklist.finished
            puts 'Archiving: ' + checklist.name
            checklist.update!(archived: true)
          end
        end
        Authorization.ignore_access_control(false)
    end
end
