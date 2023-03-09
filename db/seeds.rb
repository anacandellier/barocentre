
EventUser.destroy_all
Event.destroy_all
MeanOfTransport.destroy_all
User.destroy_all

User.create!(email: "alice@test.com", password: "alice@test.com", password_confirmation: "alice@test.com", username: "Alice")
User.create!(email: "bob@test.com", password: "bob@test.com", password_confirmation: "bob@test.com", username: "Bob")
User.create!(email: "paul@test.com", password: "paul@test.com", password_confirmation: "paul@test.com", username: "Paul")


MeanOfTransport.create!(name: "Vélo", speed: 20)
MeanOfTransport.create!(name: "Marche et transports", speed: 30)
MeanOfTransport.create!(name: "Voiture", speed: 25)


Event.create!(user: User.find_by(email: "alice@test.com"), name: "Anniv d'Alice", date: DateTime.new(2023,4,3.5))
Event.create!(user: User.find_by(email: "bob@test.com"), name: "Pot de départ de Bob", date: DateTime.new(2023,5,10.8))


#Alice qui vient à l'Anniv d'Alice
EventUser.create!(
  user_address: "13 rue carducci paris",
  mean_of_transport: MeanOfTransport.find_by(name: "Vélo"),
  event: Event.find_by(name: "Anniv d'Alice"),
  user: User.find_by(email: "alice@test.com")
)
#Bob qui vient à l'Anniv d'Alice
EventUser.create!(
  user_address: "7 rue Nicolas Roret Paris",
  mean_of_transport: MeanOfTransport.find_by(name: "Voiture"),
  event: Event.find_by(name: "Anniv d'Alice"),
  user: User.find_by(email: "bob@test.com")
)

#Paul qui vient à l'Anniv d'Alice
EventUser.create!(
  user_address: "3 impasse Piver Paris",
  mean_of_transport: MeanOfTransport.find_by(name: "Marche et transports"),
  event: Event.find_by(name: "Anniv d'Alice"),
  user: User.find_by(email: "paul@test.com")
)

#Alice qui vient au Pot de départ de Bob
EventUser.create!(
  user_address: "1 rue de Navarre Paris",
  mean_of_transport: MeanOfTransport.find_by(name: "Vélo"),
  event: Event.find_by(name: "Pot de départ de Bob"),
  user: User.find_by(email: "alice@test.com")
)
#Bob qui vient au pot de départ de Bob
EventUser.create!(
  user_address: "23 rue Clovis",
  mean_of_transport: MeanOfTransport.find_by(name: "Voiture"),
  event: Event.find_by(name: "Pot de départ de Bob"),
  user: User.find_by(email: "bob@test.com")
)

#Paul qui vient au pot de départ de Bob
EventUser.create!(
  user_address: "76 boulevard Richard Lenoir Paris",
  mean_of_transport: MeanOfTransport.find_by(name: "Marche et transports"),
  event: Event.find_by(name: "Pot de départ de Bob"),
  user: User.find_by(email: "paul@test.com")
)
