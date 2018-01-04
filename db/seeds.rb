User.destroy_all
UserGroup.destroy_all
Group.destroy_all

users = []

users << User.create!(email: 'l.b@gmail.com', first_name: 'Luke', last_name: 'Breen', password: '123456')
users << User.create!(email: 'a.duff@gmail.com', first_name: 'Alistair', last_name: 'Duff', password: '123456')
users << User.create!(email: 'w.morbey@gmail.com', first_name: 'Will', last_name: 'Morbey', password: '123456')
users << User.create!(email: 'j.delaney@gmail.com', first_name: 'Joe', last_name: 'Delaney', password: '123456')
users << User.create!(email: 'm.croall@gmail.com', first_name: 'Matt', last_name: 'Croall', password: '123456')

colours = ['#ff2d2d', '#61d8f9', '#4830ff', '#00a523', '#d84cff']

# red = '#ff2d2d'
# light_blue = '#61d8f9'
# dark_blue = '#4830ff'
# green = '#00a523'
# purple = '#d84cff'

colours.each do |colour|
	group = Group.create!(name: Faker::Beer.name, colour: colour)
	group.users = users
end

puts "DB seeded successfully"



