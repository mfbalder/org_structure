# frozen_string_literal: true

class Manager < Employee
  has_many :employees

  validates_presence_of :bonus
end
