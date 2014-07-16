# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = ['beers', 'pubs', 'distillaries', 'breweries']
addresses = ['10 Sunray Street L1N 9B5 whitby', '130 Riviera Drive L3R 5M1 markham', '245 Queens Quay W. M5J 2K9 toronto', '384 Yonge Street L4N 2Z6 barrie', '75 Victoria Street M5C 2B1 toronto', '124 Ossington Avenue M6J 2Z5 toronto', '1000 Murray Ross Parkway M3J 2P3 toronto']

100.times do
	User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
end

200.times do 
	Pledge.create(project_id: rand(1..20), user_id: rand(1..100), reward_id: rand(1..100))
end

100.times do 
	Reward.create(project_id: rand(1..20), amount: rand(1000..100000), description: Faker::Lorem.sentence)
end

10.times do 
	Project.create(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, goal: rand(1000..20000000), end_date: Date.today + rand(1..60).days, category: categories[rand(0..3)], location: addresses[rand(0..6)])
end

sleep(20)

10.times do 
	Project.create(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, goal: rand(1000..20000000), end_date: Date.today + rand(1..60).days, category: categories[rand(0..3)], location: addresses[rand(0..6)])
end

Project.all.each do |project|
	project.update_funded_amount
	project.save
end