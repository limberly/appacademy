# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.create!(
  birth_date: '2011/5/16',
  color: 'black',
  name: 'Doodoo',
  sex: 'm',
  description: 'lovely kitty baby'
)

Cat.create!(
  birth_date: '2011/5/16',
  color: 'yellow',
  name: 'Dooba',
  sex: 'f',
  description: 'another lovely kitty baby'
)