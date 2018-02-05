Group.destroy_all
User.destroy_all
Friendship.destroy_all
GroupMember.destroy_all

users = []

admin = User.create!(email: 'l.b@gmail.com', first_name: 'Luke', last_name: 'Breen', password: '123456')
users << User.create!(email: 'a.duff@gmail.com', first_name: 'Alistair', last_name: 'Duff', password: '123456')
users << User.create!(email: 'w.morbey@gmail.com', first_name: 'Will', last_name: 'Morbey', password: '123456')
users << User.create!(email: 'j.delaney@gmail.com', first_name: 'Joe', last_name: 'Delaney', password: '123456')
users << User.create!(email: 'm.croall@gmail.com', first_name: 'Matt', last_name: 'Croall', password: '123456')

Friendship.create!(user: admin, friend: users[0], status: "pending")
Friendship.create!(user: admin, friend: users[1], status: "pending")
Friendship.create!(user: admin, friend: users[2], status: "accepted")
Friendship.create!(user: admin, friend: users[3], status: "accepted")

colours = ['rgb(255, 45, 45)', 'rgb(97, 216, 249)', 'rgb(72, 48, 255)', 'rgb(0, 165, 35)', 'rgb(216, 76, 255)', 'rgb(255, 255, 255)']

# red = 'rgb(255, 45, 45)'
# light_blue = 'rgb(97, 216, 249)'
# dark_blue = 'rgb(72, 48, 255)'
# green = 'rgb(0, 165, 35)'
# purple = 'rgb(216, 76, 255)'
# white ='rgb(255, 255, 255)'

group_names = []

until group_names.length == colours.length
  name = Faker::Beer.name
  group_names << name if name.chars.length < 26
end

colours.each_with_index do |colour, index|
	group = Group.new(name: group_names[index], colour: colour)
  group.admin = admin
	group.members = users
  group.save!
end



puts "DB seeded successfully"



