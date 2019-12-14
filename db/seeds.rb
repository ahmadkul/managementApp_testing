# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin
User.create(fName: 'admin', lName: 'SBA', pCode: 'K1T 2N4', telephone: '6131234567' , email: 'admin@mail.com', password: '123456')

# User
User.create(fName: 'user', lName: 'SBA', pCode: 'K1T 2N4', telephone: '6131234567' , email: 'user@mail.com', password: '123456')