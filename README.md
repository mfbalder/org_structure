# README

This `org_structure` repo contains the following endpoints:

* `employees#show`, a GET endpoint that takes an employee ID, and returns the given employee
* `employees#create`, a POST endpoint that creates a new employee
* `mployees#update`, a PATCH endpoint that will update the given employee
* `employees#index`, a GET endpoint that returns all employees. Given a `hire_date`, it can also return only the employees hired on the given date
* `employees#employees`, a GET endpoint that, given a manager ID, will return all employees managed by that manager

## How to Run

### Requirements
* Ruby Version 3.3.0
* Rails Version 7.1.2

### Setup Steps
1. Clone this repo
2. Run migrations `bin/rails db:migrate`
3. Start up a rail server `bundle exec rails s`

### Postman
View sample calls in this [postman collection](https://www.postman.com/mfbalder/workspace/org-structure/collection/32328232-4685e88c-bf15-4568-bf6b-0071e1e84221?action=share&creator=32328232).

### `employees#show`

#### Expected Inputs
* `id` => ID of the given employee

#### Sample Request
`curl -X GET "http://127.0.0.1:3000/employees/2"`

#### Example Output
```
{
    "id": 1,
    "manager_id": null,
    "name": "Janet Snakehole",
    "date_of_birth": "1977-05-10",
    "date_of_hire": "2020-09-08",
    "created_at": "2024-01-14T23:10:19.290Z",
    "updated_at": "2024-01-14T23:10:19.290Z",
    "bonus": null
}
```

### `employees#create`

#### Expected Inputs
* `manager_id` => The ID of the employee that manages this employee. Can be nil. Must belong to an employee that is a manager.
* `name` => The employee's name, a string
* `date_of_birth` => Employee's date of birth, Date object
* `date_of_hire` => Date the employee was hired, Date object
* `bonus` => The employee's bonus, only available to Managers, and required. Two decimal points, ex. 2000.00

#### Sample Input
```
{ 
    "employee": {
    "name": "Janet Snakehole", 
    "date_of_birth": "1977-05-10", 
    "date_of_hire": "2020-09-08", 
    "manager_id": 2, 
    "bonus": 2000.00
    } 
}
```

#### Sample Output 
```
{
    "id": 18,
    "manager_id": 2,
    "name": "Janet Snakehole",
    "date_of_birth": "1977-05-10",
    "date_of_hire": "2020-09-08",
    "created_at": "2024-01-17T23:36:20.515Z",
    "updated_at": "2024-01-17T23:36:20.515Z",
    "bonus": "2000.0"
}
```

### `employees#update`

#### Expected Inputs
* `ID` => The ID of the employee to be updated
* `manager_id` => The ID of the employee that manages this employee. Can be nil. Must belong to an employee that is a manager.
* `name` => The employee's name, a string
* `date_of_birth` => Employee's date of birth, Date object
* `date_of_hire` => Date the employee was hired, Date object
* `bonus` => The employee's bonus, only available to Managers, and required. Two decimal points, ex. 2000.00

#### Sample Input
```
{ 
    "employee": {
    "name": "Janet Snakehole", 
    "date_of_birth": "1977-05-10", 
    "date_of_hire": "2020-09-08", 
    "manager_id": 2, 
    "bonus": 2000.00
    } 
}
```

#### Sample Output 
```
{
    "id": 18,
    "manager_id": 2,
    "name": "Janet Snakehole",
    "date_of_birth": "1977-05-10",
    "date_of_hire": "2020-09-08",
    "created_at": "2024-01-17T23:36:20.515Z",
    "updated_at": "2024-01-17T23:36:20.515Z",
    "bonus": "2000.0"
}
```

### `employees#index`

#### Expected (optional) Inputs
* `hire_date` => The date on which the returned employees were hired

#### Sample Request
`curl -X GET -d "hire_date=2020-09-11" "http://127.0.0.1:3000/employees"`

#### Example Output
```
[
    {
        "id": 1,
        "manager_id": null,
        "name": "Janet Snakehole",
        "date_of_birth": "1977-05-10",
        "date_of_hire": "2020-09-08",
        "created_at": "2024-01-14T23:10:19.290Z",
        "updated_at": "2024-01-14T23:10:19.290Z",
        "bonus": null
    },
    {
        "id": 2,
        "manager_id": null,
        "name": "Micki Balder",
        "date_of_birth": "1987-05-22",
        "date_of_hire": "2020-09-08",
        "created_at": "2024-01-14T23:12:04.937Z",
        "updated_at": "2024-01-14T23:12:04.937Z",
        "bonus": null
    }
]
```

### `employees#employees`

#### Expected Inputs
* `ID` => The manager ID for whom to return their employees

#### Sample Request
`curl -X GET "http://127.0.0.1:3000/employees/2/employees"`

#### Example Output
```
[
    {
        "id": 1,
        "manager_id": 2,
        "name": "Janet Snakehole",
        "date_of_birth": "1977-05-10",
        "date_of_hire": "2020-09-08",
        "created_at": "2024-01-14T23:10:19.290Z",
        "updated_at": "2024-01-14T23:10:19.290Z",
        "bonus": null
    },
    {
        "id": 2,
        "manager_id": 2,
        "name": "Micki Balder",
        "date_of_birth": "1987-05-22",
        "date_of_hire": "2020-09-08",
        "created_at": "2024-01-14T23:12:04.937Z",
        "updated_at": "2024-01-14T23:12:04.937Z",
        "bonus": null
    }
]
```


## How to Run the Test Suite
`bundle exec rspec`

## About the DB Model
This repo contains a singular table, `employees`, with the follow columns:
```
id: type: primary key, null: false,
manager_id: type: foreign key (to employees table), null: true,
date_of_birth: type: date, null: false,
date_of_hire, type: date, null: false,
created_at: type: DateTime,
updated_at: type: DateTime,
bonus: type: decimal, null: true
```