# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

House.create(address: 'first house')
House.create(address: 'second house')
House.create(address: 'third house')

Person.create(name: 'John', house_id: 1)
Person.create(name: 'Dan', house_id: 1)
Person.create(name: 'Joe', house_id: 2)
Person.create(name: 'Kat', house_id: 2)
Person.create(name: 'Steph', house_id: 3)
Person.create(name: 'Jill', house_id: 3)
