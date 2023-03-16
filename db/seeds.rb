Event.destroy_all
Bar.destroy_all
EventUser.destroy_all
User.destroy_all

laura = User.new(email: "laura@barocentre.com", password: "123456", password_confirmation: "123456", username: "Laura")
hugo = User.new(email: "hugo@barocentre.com", password: "123456", password_confirmation: "123456", username: "Hugo")
paul = User.new(email: "paul@barocentre.com", password: "123456", password_confirmation: "123456", username: "Paul")
noemie = User.new(email: "noemie@barocentre.com", password: "123456", password_confirmation: "123456", username: "Noémie")
amelie = User.new(email: "amelie@barocentre.com", password: "123456", password_confirmation: "123456", username: "Amelie")
louis = User.new(email: "louis@barocentre.com", password: "123456", password_confirmation: "123456", username: "Louis")
thomas = User.new(email: "thomas@barocentre.com", password: "123456", password_confirmation: "123456", username: "Thomas")
julie = User.new(email: "julie@barocentre.com", password: "123456", password_confirmation: "123456", username: "Julie")


julie.photo.attach(
  io: File.open('public/images/julie.png'),
  filename: 'julie.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
julie.save!

amelie.photo.attach(
  io: File.open('public/images/amelie.png'),
  filename: 'amelie.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
amelie.save!

louis.photo.attach(
  io: File.open('public/images/louis.png'),
  filename: 'louis.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
louis.save!

thomas.photo.attach(
  io: File.open('public/images/thomas.png'),
  filename: 'thomas.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
thomas.save!


laura.photo.attach(
  io: File.open('public/images/laura.png'),
  filename: 'laura.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
laura.save!

hugo.photo.attach(
  io: File.open('public/images/hugo.png'),
  filename: 'hugo.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
hugo.save!

paul.photo.attach(
  io: File.open('public/images/paul.png'),
  filename: 'paul.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
paul.save!

noemie.photo.attach(
  io: File.open('public/images/noemie.png'),
  filename: 'noemie.png', # use the extension of the attached file here
  content_type: 'image/png' # ideally use the mime type of the attached file here, like 'image/jpg''
)
noemie.save!

anniv = Event.create!(user: User.find_by(email: "laura@barocentre.com"), name: "Anniv de Laura", date: DateTime.new(2023,4,3.6))
after = Event.create!(user: User.find_by(email: "hugo@barocentre.com"), name: "Afterwork du Wagon", date: DateTime.new(2023,3,10.7))

anniv.open!
after.open!

EventUser.create!(
  user_address: "64 rue des Dames, 75017 Paris",
  transport: "driving",
  event: Event.find_by(name: "Anniv de Laura"),
  user: laura
)

EventUser.create!(
  user_address: "13 rue Carducci, 75019 Paris",
  transport: "bicycling",
  event: Event.find_by(name: "Anniv de Laura"),
  user: noemie
)


EventUser.create!(
  user_address: "7 rue Nicolas Roret, 75013 Paris",
  transport: "transit",
  event: Event.find_by(name: "Anniv de Laura"),
  user: hugo
)

EventUser.create!(
  user_address: "1 rue de Navarre Paris",
  transport: "driving",
  event: Event.find_by(name: "Afterwork du Wagon"),
  user: hugo
)

EventUser.create!(
  user_address: "23 rue Clovis",
  transport: "bicycling",
  event: Event.find_by(name: "Afterwork du Wagon"),
  user: paul
)


EventUser.create!(
  user_address: "76 boulevard Richard Lenoir Paris",
  transport: "bicycling",
  event: Event.find_by(name: "Afterwork du Wagon"),
  user: laura
)


lol = Event.create!(user: User.find_by(email: "laura@barocentre.com"), name: "Anniv de Lauracaca", date: DateTime.now + 2.hours)


eventuser_data = [
  {
    user_address: "9 Rue René Boulanger, 75010 Paris, France",
    transport: "bicycling"
  },
  {
    user_address: "68 Avenue Parmentier, 75011 Paris, France",
    transport: "bicycling"
  },
  {
    user_address: "104 Avenue Daumesnil, 75012 Paris, France",
    transport: "transit"
  },
  {
    user_address: "14 Rue Lécuyer, 75018 Paris, France",
    transport: "bicycling"
  },
  {
    user_address: "26 Rue De La Montagne Sainte-Geneviève, 75005 Paris, France",
    transport: "bicycling"
  }
]

eventuser_data.each_with_index do |data, i|
  EventUser.create!(data.merge({ user: User.all[i + 1], event: lol }))
end
