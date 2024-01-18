# frozen_string_literal: true

class Employee < ApplicationRecord
  delegated_type :employee_type, type: %w[Manager IndividualContributor]
  belongs_to :manager

  # TODO: Get this unless to work, fails if the manager ID is nil
  validates_presence_of :manager, unless: proc { |e| e.manager_id.nil? }
end
