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
  instruments: ['guitar', 'piano']
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
  instruments: ['saxophone', 'vocal']
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
  instruments: ["guitar", "vocal"],
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
  instruments: ["vocal", "ukulele"],
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

camille = User.create!(
  first_name: "Camille",
  email: "camille.dupont@example.com",
  last_name: "Dupont",
  address: "Paris, France",
  instruments: ["piano", "vocal"],
  password: common_password,
  telephone_number: '3423456789',
  password_confirmation: common_password
)

camille.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user31F.jpg")),
  filename: "user31F.jpg",
  content_type: "image/jpg"
)

isabel = User.create!(
  first_name: "Isabel",
  email: "isabel.martinez@example.com",
  last_name: "Martínez",
  address: "Madrid, Spain",
  instruments: ["guitar", "vocal"],
  password: common_password,
  telephone_number: '3423345678',
  password_confirmation: common_password
)

isabel.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user13F.jpg")),
  filename: "user13F.jpg",
  content_type: "image/jpg"
)

giulia = User.create!(
  first_name: "Giulia",
  email: "giulia.rossi@example.com",
  last_name: "Rossi",
  address: "Rome, Italy",
  instruments: ["bass guitar", "violin"],
  password: common_password,
  telephone_number: '3412345678',
  password_confirmation: common_password
)

giulia.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user19F.jpg")),
  filename: "user19F.jpg",
  content_type: "image/jpg"
)

ana = User.create!(
  first_name: "Ana",
  email: "ana.silva@example.com",
  last_name: "Silva",
  address: "Lisbon, Portugal",
  instruments: ["keyboard", "vocal"],
  password: common_password,
  telephone_number: '3287654321',
  password_confirmation: common_password
)

ana.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user20F.jpg")),
  filename: "user20F.jpg",
  content_type: "image/jpg"
)

clara = User.create!(
  first_name: "Clara",
  email: "clara.schmidt@example.com",
  last_name: "Schmidt",
  address: "Berlin, Germany",
  instruments: ["violin", "flute"],
  password: common_password,
  telephone_number: '3409876543',
  password_confirmation: common_password
)

clara.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user28F.jpg")),
  filename: "user28F.jpg",
  content_type: "image/jpg"
)

louis = User.create!(
  first_name: "Louis",
  email: "louis.benoit@example.com",
  last_name: "Benoit",
  address: "Paris, France",
  instruments: ["guitar", "piano"],
  password: common_password,
  telephone_number: '3423456789',
  password_confirmation: common_password
)

louis.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user14M.jpg")),
  filename: "user14M.jpg",
  content_type: "image/jpg"
)

jose = User.create!(
  first_name: "José",
  email: "jose.martinez@example.com",
  last_name: "Martínez",
  address: "Barcelona, Spain",
  instruments: ["guitar", "drums"],
  password: common_password,
  telephone_number: '3498765432',
  password_confirmation: common_password
)

jose.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user15M.jpg")),
  filename: "user15M.jpg",
  content_type: "image/jpg"
)

alessandro = User.create!(
  first_name: "Alessandro",
  email: "alessandro.rossi@example.com",
  last_name: "Rossi",
  address: "Milan, Italy",
  instruments: ["keyboard", "bass"],
  password: common_password,
  telephone_number: '3412345678',
  password_confirmation: common_password
)

alessandro.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user16m.jpg")),
  filename: "user16m.jpg",
  content_type: "image/jpg"
)

miguel = User.create!(
  first_name: "Miguel",
  email: "miguel.silva@example.com",
  last_name: "Silva",
  address: "Porto, Portugal",
  instruments: ["violin", "saxophone"],
  password: common_password,
  telephone_number: '3287654321',
  password_confirmation: common_password
)

miguel.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user17M.jpg")),
  filename: "user17M.jpg",
  content_type: "image/jpg"
)

lukas = User.create!(
  first_name: "Lukas",
  email: "lukas.schmidt@example.com",
  last_name: "Schmidt",
  address: "Berlin, Germany",
  instruments: ["guitar", "drums"],
  password: common_password,
  telephone_number: '3412345678',
  password_confirmation: common_password
)

lukas.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user18M.jpg")),
  filename: "user18M.jpg",
  content_type: "image/jpg"
)

maximilian = User.create!(
  first_name: "Maximilian",
  email: "maximilian.mueller@example.com",
  last_name: "Müller",
  address: "Munich, Germany",
  instruments: ["drums", "bass"],
  password: common_password,
  telephone_number: '3402345678',
  password_confirmation: common_password
)

maximilian.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user21M.jpg")),
  filename: "user21M.jpg",
  content_type: "image/jpg"
)

peter = User.create!(
  first_name: "Peter",
  email: "peter.schulz@example.com",
  last_name: "Schulz",
  address: "Berlin, Germany",
  instruments: ["guitar", "bass"],
  password: common_password,
  telephone_number: '3487654321',
  password_confirmation: common_password
)

peter.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user22M.jpg")),
  filename: "user22M.jpg",
  content_type: "image/jpg"
)

joao = User.create!(
  first_name: "João",
  email: "joao.silva@example.com",
  last_name: "Silva",
  address: "Lisbon, Portugal",
  instruments: ["bass", "guitar"],
  password: common_password,
  telephone_number: '3298765432',
  password_confirmation: common_password
)

joao.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user23M.jpg")),
  filename: "user23M.jpg",
  content_type: "image/jpg"
)

aditya = User.create!(
  first_name: "aditya",
  email: "aditya.sharma@example.com",
  last_name: "Sharma",
  address: "Lisbon, Portugal",
  instruments: ["keyboard", "drums"],
  password: common_password,
  telephone_number: '3287654321',
  password_confirmation: common_password
)

aditya.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user24M.jpg")),
  filename: "user24M.jpg",
  content_type: "image/jpg"
)

roberto = User.create!(
  first_name: "Roberto",
  email: "roberto.bianchi@example.com",
  last_name: "Bianchi",
  address: "Milan, Italy",
  instruments: ["bass guitar", "synthesizer"],
  password: common_password,
  telephone_number: '3412345678',
  password_confirmation: common_password
)

roberto.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user25M.jpg")),
  filename: "user25M.jpg",
  content_type: "image/jpg"
)

david = User.create!(
  first_name: "David",
  email: "david.johnson@example.com",
  last_name: "Johnson",
  address: "London, UK",
  instruments: ["guitar", "bass"],
  password: common_password,
  telephone_number: '3423345678',
  password_confirmation: common_password
)

david.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "user26M.jpg")),
  filename: "user26M.jpg",
  content_type: "image/jpg"
)

puts 'Creating bands...'

band1 = Band.create!(
  title: 'Metal Band',
  description: 'A metal band.',
  address: 'Rue de Rivoli, Paris',
  genre: 'Metal',
  leader_id: jane.id,
  searching_for_instruments: ["guitar", "piano"]
)

jane.update(band_id: band1.id)
jose.update!(band_id: band1.id)
louis.update!(band_id: band1.id)


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
maximilian.update!(band_id: band2.id)
miguel.update!(band_id: band2.id)

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
peter.update!(band_id: band3.id)
joao.update!(band_id: band3.id)

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
  searching_for_instruments: ["keyboard", "vocal"]
)

diana.update!(band_id: band4.id)
david.update!(band_id: band4.id)
roberto.update!(band_id: band4.id)
aditya.update!(band_id: band4.id)


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
giulia.update!(band_id: band5.id)

band5.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band5.jpg")),
  filename: "band5.jpg",
  content_type: "image/jpg"
)

band6 = Band.create!(
  title: 'Folk Harmonies',
  description: 'A folk band with rich harmonies.',
  address: 'Avenue des Champs-Élysées, Paris',
  genre: 'Folk',
  leader_id: frank.id,
  searching_for_instruments: ["acoustic guitar", "banjo"]
)

frank.update!(band_id: band6.id)
isabel.update!(band_id: band6.id)

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
clara.update!(band_id: band7.id)

band7.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band7.jpg")),
  filename: "band7.jpg",
  content_type: "image/jpg"
)

band8 = Band.create!(
  title: 'Hip Hop Crew',
  description: 'A hip hop and rap group.',
  address: 'Rue Montmartre, Paris',
  genre: 'Hip Hop',
  leader_id: hank.id,
  searching_for_instruments: ["turntables", "microphone"]
)

hank.update!(band_id: band8.id)
camille.update!(band_id: band8.id)

band8.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band8.jpg")),
  filename: "band8.jpg",
  content_type: "image/jpg"
)

band9 = Band.create!(
  title: 'Classical Ensemble',
  description: 'A classical music group.',
  address: 'Boulevard Saint-Germain, Paris',
  genre: 'Classical',
  leader_id: ivy.id,
  searching_for_instruments: ["violin", "cello"]
)

ivy.update!(band_id: band9.id)
alessandro.update!(band_id: band9.id)
ana.update!(band_id: band9.id)

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
bob.update!(band_id: band10.id)

band10.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band10.jpg")),
  filename: "band10.jpg",
  content_type: "image/jpg"
)

band11 = Band.create!(
  title: 'Lo-Fi creator',
  description: 'An old Lo-Fi band.',
  address: 'Rue du Faubourg Saint-Antoine, Paris',
  genre: 'Lo-fi',
  leader_id: lukas.id,
  searching_for_instruments: ["drums", "bass"]
)

lukas.update!(band_id: band11.id)

band11.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band11.jpg")),
  filename: "band11.jpg",
  content_type: "image/jpg"
)

band12 = Band.create!(
  title: 'R&B in Italy',
  description: 'An italian band playing good R&B.',
  address: 'Naples',
  genre: 'R&B',
  leader_id: alice.id,
  searching_for_instruments: ["drums", "bass"]
)

alice.update!(band_id: band12.id)

band12.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "band12.jpg")),
  filename: "band12.jpg",
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
