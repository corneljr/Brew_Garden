# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do 
	Project.create(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, goal: rand(1..20000), end_date: Date.today + rand(1..60).days)
end