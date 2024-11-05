# db/seeds.rb
BandSession.destroy_all
Chat.destroy_all
Band.delete_all
User.destroy_all

puts 'Creating new users...'

john = User.new(
  email: 'john.smith@example.com',
  password: 'SecurePassword123',
  password_confirmation: 'SecurePassword123',
  first_name: 'John',
  last_name: 'Doe',
  address: 'Madrid',
  telephone_number: '5557654321',
  instruments: ['Guitar', 'Piano'].to_json
)

john.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "john-doe.jpg")),
  filename: "john-doe.jpg",
  content_type: "image/jpg"
)

if john.save
  puts "Created John as a user!"
else
  puts "Failed to create John: #{john.errors.full_messages.join(", ")}"
end

jane = User.new(
  email: 'jane.smith@example.com',
  password: 'AnotherSecurePassword123',
  password_confirmation: 'AnotherSecurePassword123',
  first_name: 'Jane',
  last_name: 'Smith',
  address: 'Hauptstrasse, Berlin',
  telephone_number: '5557654321',
  instruments: ['Saxophone', 'Vocals'].to_json
)

jane.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "jane-smith.jpg")),
  filename: "jane-smith.jpg",
  content_type: "image/jpg"
)



if jane.save
  puts "Created Jane as a user!"
else
  puts "Failed to create Jane: #{jane.errors.full_messages.join(", ")}"
end

# Check if users are created successfully

# Create Band records
puts 'Creating bands...'
# Band.create!([
#   {
#     title: "The Rockers",
#     address: "Music City, NY",
#     genre: "Rock",
#     description: "A high-energy rock band that plays classic and modern rock hits.",
#     searching_for_instruments: "Lead Guitar, Drums",
#     leader_id: john.id
#   },
#   {
#     title: "Jazz Collective",
#     address: "New Orleans, LA",
#     genre: "Jazz",
#     description: "A smooth jazz ensemble featuring talented musicians.",
#     searching_for_instruments: "Saxophone, Piano",
#     leader_id: john.id
#   },
#   {
#     title: "Pop Sensations",
#     address: "Los Angeles, CA",
#     genre: "Pop",
#     description: "A pop band known for catchy tunes and energetic performances.",
#     searching_for_instruments: "Backup Vocals",
#     leader_id: john.id
#   },
#   {
#     title: "Metal Warriors",
#     address: "Austin, TX",
#     genre: "Metal",
#     description: "Heavy metal band with powerful riffs and intense performances.",
#     searching_for_instruments: "Bass Guitar, Drums",
#     leader_id: john.id
#   },
#   {
#     title: "Classical Harmony",
#     address: "Vienna, VA",
#     genre: "Classical",
#     description: "An orchestra that performs classical masterpieces.",
#     searching_for_instruments: "Violin, Cello",
#     leader_id: john.id
#   },
#   {
#     title: "Indie Vibes",
#     address: "Seattle, WA",
#     genre: "Indie",
#     description: "An indie band with a unique sound and style.",
#     searching_for_instruments: "Keyboard, Bass Guitar",
#     leader_id: jane.id
#   },
#   {
#     title: "Folk Tales",
#     address: "Nashville, TN",
#     genre: "Folk",
#     description: "A folk band that tells stories through music.",
#     searching_for_instruments: "Banjo, Harmonica",
#     leader_id: jane.id
#   },
#   {
#     title: "Hip Hop Legends",
#     address: "Atlanta, GA",
#     genre: "Hip Hop",
#     description: "A hip hop group known for their lyrical prowess.",
#     searching_for_instruments: "DJ, Beat Maker",
#     leader_id: jane.id
#   },
#   {
#     title: "Reggae Roots",
#     address: "Kingston, Jamaica",
#     genre: "Reggae",
#     description: "A reggae band promoting peace and love through music.",
#     searching_for_instruments: "Guitar, Percussion",
#     leader_id: jane.id
#   },
#   {
#     title: "Blues Brothers",
#     address: "Chicago, IL",
#     genre: "Blues",
#     description: "A blues band with a rich history of soulful performances.",
#     searching_for_instruments: "Harmonica, Guitar",
#     leader_id: jane.id
#   }
# ])

puts 'Bands created successfully!'
band1 = Band.create!(
  title: 'Metal Band',
  description: 'A metal band.',
  address: 'Paris',
  genre: 'Metal',
  leader_id: jane.id
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
    leader_id: john.id
  )

  band2.photo.attach(
    io: File.open(Rails.root.join("app", "assets", "images", "jazz-band.jpg")),
    filename: "jazz-band.jpg",
    content_type: "image/jpg"
  )

puts 'Seeding completed!'

band_session = BandSession.create!(
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
