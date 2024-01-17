# frozen_string_literal: true

class EmployeesController < ApplicationController
  def create
    employee = Employee.create!(employee_params)
    render json: employee
  end

  def update
    employee = Employee.find_by(id: params[:id])
    employee.update!(employee_params)

    render json: employee
  end

  def show
    employee = Employee.find_by(id: params[:id])
    render json: employee
  end

  def index
    employees = if params[:hire_date]
                  Employee.where(hire_date: params[:hire_data])
                else
                  Employee.all
                end

    render json: employees
  end

  def employees
    employees = Manager.find_by(id: params[:employee_id]).employees

    render json: employees
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :date_of_birth, :date_of_hire, :manager_id, :type, :bonus)
  end
end
