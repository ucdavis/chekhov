json.array!(@checklists) do |checklist|
   json.extract! checklist, :user, :started, :finished, :time_elapsed, :ticket_number 
end
