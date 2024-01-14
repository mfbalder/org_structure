# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.references :manager, null: true, foreign_key: { to_table: :employees }, comment: 'The manager for this employee'
      t.string :type, comment: 'The type of employee'
      t.string :name, comment: 'The name of the employee'
      t.datetime :date_of_birth, comment: 'The employee DOB'
      t.datetime :date_of_hire, comment: 'The date the employee was hired'
      t.timestamps
    end
  end
end
