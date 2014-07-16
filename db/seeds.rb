# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = ['beers', 'pubs', 'distillaries', 'breweries']

100.times do
	User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
end

200.times do 
	Pledge.create(project_id: rand(1..20), user_id: rand(1..100), reward_id: rand(1..100), amount: rand(1000..100000))
end

100.times do 
	Reward.create(project_id: rand(1..20), amount: rand(1000..100000), description: Faker::Lorem.sentence)
end

20.times do 
	Project.create(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, goal: rand(1..20000), end_date: Date.today + rand(1..60).days, category: categories[rand(0..3)])
end