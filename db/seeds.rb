Group.destroy_all
User.destroy_all
Friendship.destroy_all
GroupMember.destroy_all
Message.destroy_all

users = []

admin = User.create!(email: 'l.b@gmail.com', first_name: 'Luke', last_name: 'Breen', password: '123456')
users << User.create!(email: 'a.duff@gmail.com', first_name: 'Alistair', last_name: 'Duff', password: '123456')
users << User.create!(email: 'w.morbey@gmail.com', first_name: 'Will', last_name: 'Morbey', password: '123456')
users << User.create!(email: 'j.delaney@gmail.com', first_name: 'Joe', last_name: 'Delaney', password: '123456')
users << User.create!(email: 'm.croall@gmail.com', first_name: 'Matt', last_name: 'Croall', password: '123456')

User.create!(email: 'k.warren@gmail.com', first_name: 'Katy', last_name: 'Warren', password: '123456')
User.create!(email: 'k.arnold@gmail.com', first_name: 'Katie', last_name: 'Arnold', password: '123456')
User.create!(email: 'c.uthayakumar@gmail.com', first_name: 'Cynthia', last_name: 'Uthayakumar', password: '123456')
User.create!(email: 'r.elfassy_bitoun@gmail.com', first_name: 'Rachel', last_name: 'Elfassy-Bitoun', password: '123456')
User.create!(email: 'v.botella@gmail.com', first_name: 'Victoria', last_name: 'Botella', password: '123456')
User.create!(email: 'm.heller@gmail.com', first_name: 'Matt', last_name: 'Heller', password: '123456')
User.create!(email: 's.lacey@gmail.com', first_name: 'Sam', last_name: 'Lacey', password: '123456')


Friendship.create!(user: admin, friend: users[0], status: "accepted")
Friendship.create!(user: admin, friend: users[1], status: "accepted")
Friendship.create!(user: admin, friend: users[2], status: "pending")
Friendship.create!(user: admin, friend: users[3], status: "pending")

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
	group.members = [users[0], users[1]]
  group.save!
end

groups = Group.all

Friendship.create!(user: users[0], friend: users[3], status: "accepted")
not_admin_group = Group.new(name: "Not admin", admin: users[0])
not_admin_group.members = [admin, users[3]]
not_admin_group.save!

group = Group.all[0]
Message.create(user: admin, group: group, content: "Who's turn is it?")
Message.create(user: users[0], group: group, content: "Pretty sure its Will's turn...")
Message.create(user: users[1], group: group, content: "No wuz but joe's last brew was poor")
Message.create(user: users[2], group: group, content: "Pfft, you let it go cold")

puts "DB seeded successfully"



