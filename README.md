# API application on Ruby on Rails

## How to use

### Use git clone to clone repository

`git clone https://github.com/Falren/test_random_users.git`

### Run bundle (Gemfile)
  
`bundle`

### Run:
  
`rails db:create`

`rails db:migrate`

### Populate the DB
`rails db:seed`

### Start the server

`rails s`

### Returns random person
* use GET:
* path `http://127.0.0.1:3000/api/v1/random_person`

### Returns a list of people by name
* use GET:
* path `http://127.0.0.1:3000/api/v1/people?name='Linda'`
* params: name
  
### Returns person family by id
* use GET:
* path `http://127.0.0.1:3000/api/v1/family?id=1`
* params: id


### Returns all the children in the country:
* use GET:
* path `http://127.0.0.1:3000/api/v1/children?country=de`
* params: country

### Returns all the parents in the country:
* use GET:
* path `http://127.0.0.1:3000/api/v1/parents?country=de`
* params: country

## You can find list of countries here:
* https://randomuser.me/documentation

## Run Rspec

`rspec`

## Assumptions

The random user api doesn't provide collection of users under 20 years old, we create them by putting registration age instead
