json.checklists do
    json.array!(@checklists) do |checklist|
      json.extract! checklist, :user, :started, :finished, :time_elapsed, :ticket_number 
    end
end
 
json.visits do
    json.array! @visits.keys do |visit|
        json.date visit
        json.number @visits[visit]
    end
end
