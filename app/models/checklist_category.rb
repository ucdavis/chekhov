class ChecklistCategory < ActiveRecord::Base
  has_many :checklists
end
