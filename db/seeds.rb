# db/seeds.rb
BandSession.destroy_all
Chat.destroy_all

# Remove the band reference from users before destroying
User.update_all(band_id: nil)

Band.destroy_all
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
  instruments: ['Guitar', 'Piano']
)

john.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "john-doe.jpg")),
  filename: "john-doe.jpg",
  content_type: "image/jpg"
)

if john.save
  puts "Created John as a user!"
else
  puts "Failed to create John: #{john.errors.full_messages.join(',')}"
end

jane = User.new(
  email: 'jane.smith@example.com',
  password: 'AnotherSecurePassword123',
  password_confirmation: 'AnotherSecurePassword123',
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

if jane.save
  puts "Created Jane as a user!"
else
  puts "Failed to create Jane: #{jane.errors.full_messages.join(',')}"
end

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
