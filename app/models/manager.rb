class Manager < Employee
    has_many :employees

    validates_presence_of :bonus
end
