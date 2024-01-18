# frozen_string_literal: true

class IndividualContributor < Employee
  has_one :employee, as: :employee_type
end
