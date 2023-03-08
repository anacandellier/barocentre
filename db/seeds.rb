# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: "bob@test.com", password: "bobtest", password_confirmation: "bobtest")

MeanOfTransport.create(name: "Velo", speed: 20)

Event.create!(user: User.first, name: "anniv", time: DateTime.now)

EventUser.create!(
  user_address: "13 rue des dames paris",
  mean_of_transport: MeanOfTransport.first,
  event: Event.last,
  user: User.first
)

