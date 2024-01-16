class Employee < ApplicationRecord
    belongs_to :manager

    validates_presence_of :manager, unless: Proc.new { |e| e.manager_id == nil }

end
