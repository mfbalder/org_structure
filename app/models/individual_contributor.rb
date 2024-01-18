# frozen_string_literal: true

class IndividualContributor < Employee
  validates_presence_of :manager, unless: proc { |e| e.manager_id.nil? }

  belongs_to :manager
end
