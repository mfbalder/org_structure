class AddBonusToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_column :employees, :bonus, :decimal, precision: 10, scale: 2, null: true, comment: 'The bonus for a manager'
  end
end
