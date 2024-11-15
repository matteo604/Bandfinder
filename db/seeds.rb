# db/seeds.rb
BandSession.destroy_all
Chat.destroy_all
JoinRequest.destroy_all
User.update_all(band_id: nil)

Band.destroy_all
User.destroy_all

puts 'Creating new users...'
common_password = "123456"

john = User.create!(
  email: 'john.smith@example.com',
  password: common_password,
  password_confirmation: common_password,
  first_name: 'John',
  last_name: 'Doe',
  address: 'Madrid',
  telephone_number: '5557654321',
  instruments: ['Guitar', 'Piano']
)

john.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "john-doe.jpg")),
  filename: "john-doe.jpg",
  content_type: "image/jpg"
)

jane = User.create!(
  email: 'jane.smith@example.com',
  password: common_password,
  password_confirmation: common_password,
  first_name: 'Jane',
  last_name: 'Smith',
  address: 'Hauptstrasse, Berlin',
  telephone_number: '5557654321',
  instruments: ['Saxophone', 'Vocals']
)

jane.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "jane-smith.jpg")),
  filename: "jane-smith.jpg",
  content_type: "image/jpg"
)

alice = User.create!(
  first_name: "Alice",
  email: "alice.dupont@example.com",
  last_name: "Dupont",
  address: "Paris, France",
  instruments: ["guitar", "vocals"],
  password: common_password,
  telephone_number: '3223233223',
  password_confirmation: common_password
)

alice.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user3F.jpg")),
  filename: "user3F.jpg",
  content_type: "image/jpg"
)

bob = User.create!(
  first_name: "Bob",
  email: "bob.schmidt@example.com",
  last_name: "Schmidt",
  address: "Berlin, Germany",
  instruments: ["drums", "bass guitar"],
  telephone_number: '2313123133',
  password: common_password,
  password_confirmation: common_password
)

bob.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user6m.jpg")),
  filename: "user6m.jpg",
  content_type: "image/jpg"
)

charlie = User.create!(
  first_name: "Charlie",
  email: "charlie.garcia@example.com",
  last_name: "García",
  address: "Madrid, Spain",
  telephone_number: '13212312312',
  instruments: ["keyboard", "synthesizer"],
  password: common_password,
  password_confirmation: common_password
)

charlie.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user7M.jpg")),
  filename: "user7M.jpg",
  content_type: "image/jpg"
)

diana = User.create!(
  first_name: "Diana",
  email: "diana.mancini@example.com",
  last_name: "Mancini",
  address: "Milan, Italy",
  telephone_number: '333334421',
  instruments: ["violin", "piano"],
  password: common_password,
  password_confirmation: common_password
)

diana.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user4F.jpg")),
  filename: "user4F.jpg",
  content_type: "image/jpg"
)

eve = User.create!(
  first_name: "Eve",
  email: "eve.ferreira@example.com",
  last_name: "Ferreira",
  address: "Lisbon, Portugal",
  telephone_number: '32423432423',
  instruments: ["acoustic guitar", "harmonica"],
  password: common_password,
  password_confirmation: common_password
)

eve.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user5F.jpg")),
  filename: "user5F.jpg",
  content_type: "image/jpg"
)

frank = User.create!(
  first_name: "Frank",
  email: "frank.bauer@example.com",
  last_name: "Bauer",
  address: "Munich, Germany",
  telephone_number: '432423423423',
  instruments: ["bass", "electric guitar"],
  password: common_password,
  password_confirmation: common_password
)

frank.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user8m.jpg")),
  filename: "user8m.jpg",
  content_type: "image/jpg"
)

grace = User.create!(
  first_name: "Grace",
  email: "grace.rodriguez@example.com",
  last_name: "Rodríguez",
  address: "Barcelona, Spain",
  telephone_number: '32423423423',
  instruments: ["vocals", "ukulele"],
  password: common_password,
  password_confirmation: common_password
)

grace.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user10F.jpg")),
  filename: "user10F.jpg",
  content_type: "image/jpg"
)

hank = User.create!(
  first_name: "Hank",
  email: "hank.ramos@example.com",
  last_name: "Ramos",
  address: "Porto, Portugal",
  telephone_number: '1213213123',
  instruments: ["percussion", "trumpet"],
  password: common_password,
  password_confirmation: common_password
)

hank.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user9M.jpg")),
  filename: "user9M.jpg",
  content_type: "image/jpg"
)

ivy = User.create!(
  first_name: "Ivy",
  email: "ivy.caruso@example.com",
  last_name: "Caruso",
  address: "Venice, Italy",
  instruments: ["cello", "flute"],
  telephone_number: '12412412412',
  password: common_password,
  password_confirmation: common_password
)

ivy.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user12F.jpg")),
  filename: "user12F.jpg",
  content_type: "image/jpg"
)

jack = User.create!(
  first_name: "Jack",
  email: "jack.leroy@example.com",
  last_name: "Leroy",
  telephone_number: '34223423423',
  address: "Lyon, France",
  instruments: ["bass guitar", "drums"],
  password: common_password,
  password_confirmation: common_password
)

jack.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user11M.jpg")),
  filename: "user11M.jpg",
  content_type: "image/jpg"
)

puts 'Creating bands...'

band1 = Band.create!(
  title: 'Metal Band',
  description: 'A metal band.',
  address: 'Paris',
  genre: 'Metal',
  leader_id: jane.id,
  searching_for_instruments: ["guitar", "piano"]
)

jane.update(band_id: band1.id)

alice.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user3F.jpg")),
  filename: "user3F.jpg",
  content_type: "image/jpg"
)

band1.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "bandfinder.jpg")),
  filename: "bandfinder.jpg",
  content_type: "image/jpg"
)

band2 = Band.create!(
  title: 'Jazz Vibes',
  description: 'A smooth jazz ensemble with a blend of contemporary and classic styles.',
  address: 'Berlin',
  genre: 'Jazz',
  leader_id: john.id,
  searching_for_instruments: ["saxophone", "drums"]
)

john.update(band_id: band2.id)

band2.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "jazz-band.jpg")),
  filename: "jazz-band.jpg",
  content_type: "image/jpg"
)

band3 = Band.create!(
  title: 'Rock Legends',
  description: 'A rock band playing classics.',
  address: 'London',
  genre: 'Rock',
  leader_id: charlie.id,
  searching_for_instruments: ["guitar", "bass"]
)

charlie.update!(band_id: band3.id)

band3.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band3.jpg")),
  filename: "band3.jpg",
  content_type: "image/jpg"
)

band4 = Band.create!(
  title: 'Pop Stars',
  description: 'A group of aspiring pop artists.',
  address: 'Paris',
  genre: 'Pop',
  leader_id: diana.id,
  searching_for_instruments: ["keyboard", "vocals"]
)

diana.update!(band_id: band4.id)

band4.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band4.jpg")),
  filename: "band4.jpg",
  content_type: "image/jpg"
)

band5 = Band.create!(
  title: 'Blues Revival',
  description: 'Bringing back the blues.',
  address: 'Torin',
  genre: 'Blues',
  leader_id: eve.id,
  searching_for_instruments: ["harmonica", "drums"]
)
eve.update!(band_id: band5.id)

band5.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band5.jpg")),
  filename: "band5.jpg",
  content_type: "image/jpg"
)

band6 = Band.create!(
  title: 'Folk Harmonies',
  description: 'A folk band with rich harmonies.',
  address: 'New York',
  genre: 'Folk',
  leader_id: frank.id,
  searching_for_instruments: ["acoustic guitar", "banjo"]
)

frank.update!(band_id: band6.id)

band6.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band6.jpg")),
  filename: "band6.jpg",
  content_type: "image/jpg"
)

band7 = Band.create!(
  title: 'Electronic Beats',
  description: 'Exploring electronic soundscapes.',
  address: 'Munich',
  genre: 'Electronic',
  leader_id: grace.id,
  searching_for_instruments: ["synthesizer", "DJ equipment"]
)

grace.update!(band_id: band7.id)

band7.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band7.jpg")),
  filename: "band7.jpg",
  content_type: "image/jpg"
)

band8 = Band.create!(
  title: 'Hip Hop Crew',
  description: 'A hip hop and rap group.',
  address: 'Lisbon',
  genre: 'Hip Hop',
  leader_id: hank.id,
  searching_for_instruments: ["turntables", "microphone"]
)

hank.update!(band_id: band8.id)

band8.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band8.jpg")),
  filename: "band8.jpg",
  content_type: "image/jpg"
)

band9 = Band.create!(
  title: 'Classical Ensemble',
  description: 'A classical music group.',
  address: 'Vienna',
  genre: 'Classical',
  leader_id: ivy.id,
  searching_for_instruments: ["violin", "cello"]
)

ivy.update!(band_id: band9.id)

band9.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band9.jpg")),
  filename: "band9.jpg",
  content_type: "image/jpg"
)

band10 = Band.create!(
  title: 'Reggae Vibes',
  description: 'A band bringing reggae rhythms.',
  address: 'Barcelona',
  genre: 'Reggae',
  leader_id: jack.id,
  searching_for_instruments: ["drums", "bass"]
)

jack.update!(band_id: band10.id)

band10.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band10.jpg")),
  filename: "band10.jpg",
  content_type: "image/jpg"
)

puts 'Bands created successfully!'

BandSession.create!(
  title: 'The Echoes first session',
  description: 'A rock band known for their energetic performances and catchy tunes.',
  address: '17 Lydden Rd, London SW18 4LT',
  start_date: Date.today,
  end_date: Date.today + 30.days,
  creator_id: john.id,
  band_id: band1.id
)

BandSession.create!(
  title: 'The Echoes second session',
  description: 'A jazz band session filled with improvisation and fun.',
  address: '15 Jazz Lane, New Orleans, LA',
  start_date: Date.today,
  end_date: Date.today + 30.days,
  creator_id: jane.id,
  band_id: band2.id
)

puts 'Band sessions created successfully!'
puts 'Seeding completed!'
