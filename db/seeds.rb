User.destroy_all
Group.destroy_all

users = []

5.times do
  users << User.create!(
 	email: Faker::Internet.email,
	first_name: Faker::Name.first_name,
	last_name: Faker::Name.last_name,
	password: '123456'		
	)
end

3.times do
	group = Group.create!(
			name: Faker::Beer.name,
			colour: Faker::Color.hex_color
		)
	group.users = users
end

puts "DB seeded successfully"