# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.firs
random = Random.new

puts "Create Account admin"
User.create!(name:  "Admin",
             email: "admin@gmail.com",
             password:              "admin1",
             password_confirmation: "admin1",
             admin: true)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@gmail.org"
	password = "123456"
	gender = random.rand(1)
	User.create!(name: name,
		email: email,
		password: password,
		gender: gender,
		admin: false,
		password_confirmation: password,
		intro: "This is user example-#{n+1}")
end
puts "Created 99 Account"

100.times do |n|
	title = Faker::Book.title
	desc = "This is description for #{title}."
	author = Faker::Name.name
	Song.create!(title: title,
		description: desc,
		author_name: author,
				 sum_rate: 0,
				 rate_avg: 0)
end
puts "Created 200 Author"

Song.all.each do |s|
	5.times do |x|
		title = Faker::Book.title
		content = Faker::HarryPotter.quote + Faker::HarryPotter.quote
		user_id = random.rand(1..50)
		rate_rv = random.rand(0..5)
		Review.create!( title: title,
			content: content,
			user_id: user_id,
			song_id: s.id,
			rate_score: rate_rv
			)
		s.update_attributes( :rate_avg => ((s.sum_rate*s.rate_avg + rate_rv)/(s.sum_rate + 1)), :sum_rate => (s.sum_rate + 1))
	end
end
puts "Created song for author"

50.times do |x|
	name = Faker::Name.name
	Singer.create!(name: name)
end
10.times do |x|
	category = Faker::Book.genre
	Category.create!(name: category)
end
Song.all.each do |s|
	2.times do |x|
		category_id = random.rand(1..10)
		RelSongCategory.create!(
			song_id: s.id,
			category_id: category_id
			)
	end
end

puts "Created 50 Singer"

Song.all.each do |s|
	id = random.rand(1..30)
	SongSinger.create!( singer_id: id,
		song_id: s.id
		)
end
puts "Created Song for Singer"
