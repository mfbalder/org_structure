class Employee < ApplicationRecord
    belongs_to :manager

    #TODO: Get this unless to work, fails if the manager ID is nil
    validates_presence_of :manager, unless: Proc.new { |e| e.manager_id == nil }

end
