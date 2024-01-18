# frozen_string_literal: true

class Manager < Employee
  has_one :employee, as: :employee_type
  has_many :employees

  validates_presence_of :bonus
end
