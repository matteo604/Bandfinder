# db/seeds.rb

BandSession.delete_all
Band.delete_all

puts 'Creating new users...'

existing_users = User.where(id: [75, 76, 77]).pluck(:id)

# Create users only if they do not already exist
User.create!(id: 75, email: 'john.doe@example.com', password: 'SecurePassword123',
             password_confirmation: 'SecurePassword123', first_name: 'John', last_name: 'Doe',
             address: 'New York', telephone_number: '5551234567',
             instruments: ['Guitar', 'Piano'].to_json) unless existing_users.include?(75)

User.create!(id: 76, email: 'jane.smith@example.com', password: 'AnotherSecurePassword123',
             password_confirmation: 'AnotherSecurePassword123', first_name: 'Jane', last_name: 'Smith',
             address: 'Hauptstrasse, Berlin', telephone_number: '5557654321',
             instruments: ['Saxophone', 'Vocals'].to_json) unless existing_users.include?(76)


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
Band.create!([
  {
    title: "The Rockers",
    address: "Music City, NY",
    genre: "Rock",
    description: "A high-energy rock band that plays classic and modern rock hits.",
    searching_for_instruments: "Lead Guitar, Drums",
    leader_id: 75
  },
  {
    title: "Jazz Collective",
    address: "New Orleans, LA",
    genre: "Jazz",
    description: "A smooth jazz ensemble featuring talented musicians.",
    searching_for_instruments: "Saxophone, Piano",
    leader_id: 76
  },
  {
    title: "Pop Sensations",
    address: "Los Angeles, CA",
    genre: "Pop",
    description: "A pop band known for catchy tunes and energetic performances.",
    searching_for_instruments: "Backup Vocals",
    leader_id: 77
  },
  {
    title: "Metal Warriors",
    address: "Austin, TX",
    genre: "Metal",
    description: "Heavy metal band with powerful riffs and intense performances.",
    searching_for_instruments: "Bass Guitar, Drums",
    leader_id: 75
  },
  {
    title: "Classical Harmony",
    address: "Vienna, VA",
    genre: "Classical",
    description: "An orchestra that performs classical masterpieces.",
    searching_for_instruments: "Violin, Cello",
    leader_id: 76
  },
  {
    title: "Indie Vibes",
    address: "Seattle, WA",
    genre: "Indie",
    description: "An indie band with a unique sound and style.",
    searching_for_instruments: "Keyboard, Bass Guitar",
    leader_id: 77
  },
  {
    title: "Folk Tales",
    address: "Nashville, TN",
    genre: "Folk",
    description: "A folk band that tells stories through music.",
    searching_for_instruments: "Banjo, Harmonica",
    leader_id: 75
  },
  {
    title: "Hip Hop Legends",
    address: "Atlanta, GA",
    genre: "Hip Hop",
    description: "A hip hop group known for their lyrical prowess.",
    searching_for_instruments: "DJ, Beat Maker",
    leader_id: 76
  },
  {
    title: "Reggae Roots",
    address: "Kingston, Jamaica",
    genre: "Reggae",
    description: "A reggae band promoting peace and love through music.",
    searching_for_instruments: "Guitar, Percussion",
    leader_id: 77
  },
  {
    title: "Blues Brothers",
    address: "Chicago, IL",
    genre: "Blues",
    description: "A blues band with a rich history of soulful performances.",
    searching_for_instruments: "Harmonica, Guitar",
    leader_id: 75
  }
])

puts 'Bands created successfully!'

<<<<<<< HEAD
# Create band sessions (adjust band IDs if needed)
puts 'Creating band sessions...'
band1 = Band.find_by(title: "The Rockers")
band2 = Band.find_by(title: "Jazz Collective")

BandSession.create!(
=======
  band1.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "bandfinder.jpg")),
  filename: "bandfinder.jpg",
  content_type: "image/jpg"
  )


  if band1.save
    puts "Created band: #{band1.title}"
  else
    puts "Failed to create band: #{band1.errors.full_messages.join(", ")}"
  end

  band2 = Band.new(
    title: 'Jazz Vibes',
    description: 'A smooth jazz ensemble with a blend of contemporary and classic styles.',
    address: 'Paris',
    genre: 'Jazz',
    leader_id: john.id
  )

  band2.photo.attach(
    io: File.open(Rails.root.join("app", "assets", "images", "jazz-band.jpg")),
    filename: "jazz-band.jpg",
    content_type: "image/jpg"
  )


  if band2.save
    puts "Created band: #{band2.title}"
  else
    puts "Failed to create band: #{band2.errors.full_messages.join(", ")}"
  end
else
  puts "Cannot create bands because one or both users were not created successfully."
end

puts 'Seeding completed!'

band_session = BandSession.create!(
>>>>>>> 441d90878c164ea9dda678924011ce9c458ffdec
  title: 'The Echoes first session',
  description: 'A rock band known for their energetic performances and catchy tunes.',
  address: '17 Lydden Rd, London SW18 4LT',
  start_date: Date.today,
  end_date: Date.today + 30.days,
  creator_id: User.find(75).id, # Assuming this is John
  band_id: band1.id
)

BandSession.create!(
  title: 'The Echoes second session',
  description: 'A jazz band session filled with improvisation and fun.',
  address: '15 Jazz Lane, New Orleans, LA',
  start_date: Date.today,
  end_date: Date.today + 30.days,
  creator_id: User.find(76).id, # Assuming this is Jane
  band_id: band2.id
)

puts 'Band sessions created successfully!'
