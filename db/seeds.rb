 # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
  cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
  Mayor.create(name: 'Emanuel', city: cities.first)

categories = ['Brew Pubs', 'Contract Breweries', 'Microbreweries', 'Nanobreweries']
addresses = ['10 Sunray Street L1N 9B5 whitby', '130 Riviera Drive L3R 5M1 markham', '245 Queens Quay W. M5J 2K9 toronto', '384 Yonge Street L4N 2Z6 barrie', '75 Victoria Street M5C 2B1 toronto', '124 Ossington Avenue M6J 2Z5 toronto', '1000 Murray Ross Parkway M3J 2P3 toronto']

100.times do
	User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password', description: Faker::Lorem.sentences(3).join(' '))
end

200.times do 
	Pledge.create(project_id: rand(1..20), user_id: rand(1..100), reward_id: rand(1..100))
end

100.times do 
	Reward.create(project_id: rand(1..20), amount: rand(10000..100000), pledges_left: rand(1..4), description: Faker::Lorem.sentence, shipping: rand > 0.5 ? true : false)
end


20.times do 
	@project = Project.create(title: Faker::Company.name, description: Faker::Lorem.paragraphs(5).join('<br><br>'), goal: rand(100000..1000000), category: categories.sample, location: addresses.sample, user_id: rand(1..100), short_blurb: Faker::Lorem.sentences(2).join(' '), video_link: 'www.youtube.com/watch?v=KpKy6KAHaTQ', post_status: true, days_left: rand(20..60))
end


100.times do 
	Comment.create(user_id: rand(1..100), body: Faker::Lorem.sentences(2).join(' '), commentable_id: rand(1..20), commentable_type: 'Project')
end


Project.all.each do |project|
	project.update_funded_amount
	project.update_video_link
	project.save
end


(1..20).each do |n|
	SliderImage.create(project_id: n)
end
