Group.destroy_all
User.destroy_all
UserGroup.destroy_all

users = []

users << User.create!(email: 'l.b@gmail.com', first_name: 'Luke', last_name: 'Breen', password: '123456')
users << User.create!(email: 'a.duff@gmail.com', first_name: 'Alistair', last_name: 'Duff', password: '123456')
users << User.create!(email: 'w.morbey@gmail.com', first_name: 'Will', last_name: 'Morbey', password: '123456')
users << User.create!(email: 'j.delaney@gmail.com', first_name: 'Joe', last_name: 'Delaney', password: '123456')
users << User.create!(email: 'm.croall@gmail.com', first_name: 'Matt', last_name: 'Croall', password: '123456')

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
	group = Group.create!(name: group_names[index], colour: colour, user: users.first)
	group.users = users[1..4]
end

puts "DB seeded successfully"



