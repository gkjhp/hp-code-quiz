# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

unless Rails.env.test?
  p = 'fortytwo'
  u1 = User.create(email: 'host@numberwa.ng', password: p, password_confirmation: p)
  u2 = User.create(email: 'contestant1@numberwa.ng', password: p, password_confirmation: p)
  u3 = User.create(email: 'contestant2@numberwa.ng', password: p, password_confirmation: p)

  p1 = Post.create(user: u2, content: '3?')
  Post.create(user: u1, content: 'Bad luck.', parent: p1)
  p2 = Post.create(user: u3, content: 'Three?')
  Post.create(user: u1, content: "That's numberwang!", parent: p2)
  Post.create(user: u2, content: "How?", parent: p2)
  Post.create(user: u1, content: "Consult your rules pamphlet", parent: p2)
  p3 = Post.create(user: u2, content: "Twelve and a half")
  Post.create(user: u1, content: "Judges?", parent: p3)
  Post.create(user: u1, content: "No", parent: p3)
  Post.create(user: u1, content: "And that's all the time we have for today")
  Post.create(user: u2, content: "5.6?")
  p4 = Post.create(user: u2, content: "123,532,324.5555?")
  Post.create(user: u1, content: "Be sure to tune in tomorrow!", parent: p4)
end
