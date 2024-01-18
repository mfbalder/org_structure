# frozen_string_literal: true

require 'rails_helper'
require './app/controllers/employees_controller'

RSpec.describe 'Employees', type: :request do
  describe 'POST employees#create' do
    it 'creates manager with valid attributes' do
      employee_params = { employee: {
        name: 'Jane Doe',
        date_of_birth: Date.today - 30.years,
        date_of_hire: Date.yesterday,
        type: 'Manager',
        bonus: 1200.00,
        manager_id: nil
      } }
      post '/employees', params: employee_params.to_json, headers: { "Content-Type": 'application/json' }
      JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
    end

    it 'doesnt create a maanger with no bonus' do
      employee_params = { employee: {
        name: 'Jane Doe',
        date_of_birth: Date.today - 30.years,
        date_of_hire: Date.yesterday,
        type: 'Manager',
        bonus: nil,
        manager_id: nil
      } }
      post '/employees', params: employee_params.to_json, headers: { "Content-Type": 'application/json' }
      JSON.parse(response.body)
      expect(response).to have_http_status(400)
    end
  end

  describe 'GET employees#show' do
    let(:manager) do
      Employee.create!(type: 'Manager', name: 'Jane Doe', date_of_birth: Date.today - 30.years,
                       date_of_hire: Date.yesterday, bonus: 1200.00)
    end

    it 'returns the expect employee' do
      get '/employees', params: { id: manager.id }
      JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.body).to include('name')
    end
  end

  describe 'GET employees#index' do
    let!(:manager) do
      Employee.create!(type: 'Manager', name: 'Jane Doe', date_of_birth: Date.today - 30.years,
                       date_of_hire: Date.yesterday, bonus: 1200.00)
    end
    let!(:ic) do
      Employee.create!(type: 'IndividualContributor', name: 'Jane Doe', date_of_birth: Date.today - 30.years,
                       date_of_hire: Date.today - 2.days, manager_id: manager.id)
    end

    it 'returns the given employees' do
      get '/employees'
      JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.body.length).to eq(2)
    end

    it 'filters based on hire date' do
      get '/employees', params: { hire_date: Date.yesterday }
      JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.body.length).to eq(1)
    end
  end
end
