require "uri"


Band.destroy_all
User.destroy_all
# BandSession.destroy_all


puts 'Creating users...'

john = User.new(
  email: 'john.doe@example.com',
  password: 'SecurePassword123',
  password_confirmation: 'SecurePassword123',
  first_name: 'John',
  last_name: 'Doe',
  address: 'New York',
  telephone_number: '5551234567',
  instruments: ['Guitar', 'Piano'].to_json
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
if jane.save
  puts "Created Jane as a user!"
else
  puts "Failed to create Jane: #{jane.errors.full_messages.join(", ")}"
end

# Check if users are created successfully

puts 'Creating bands...'

if john.persisted? && jane.persisted?
  band1 = Band.new(
    title: 'The Echoes',
    description: 'A rock band known for their energetic performances and catchy tunes.',
    address: 'Madrid',
    genre: 'Rock',
    leader_id: jane.id
  )

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
  title: 'The Echoes first session',
  description: 'A rock band known for their energetic performances and catchy tunes.',
  address: '17 Lydden Rd, London SW18 4LT',
  start_date: Date.today,
  end_date: Date.today + 30.days,
  creator_id: john.id,
  band_id: band1.id
)

band_session.save

band_session1 = BandSession.create!(
  title: 'The Echoes first session',
  description: 'A rock band known for their energetic performances and catchy tunes.',
  address: '17 Lydden Rd, London SW18 4LT',
  start_date: Date.today,
  end_date: Date.today + 30.days,
  creator_id: john.id,
  band_id: band2.id
)

band_session1.save

band_session2 = BandSession.create!(
  title: 'The Echoes first session',
  description: 'A rock band known for their energetic performances and catchy tunes.',
  address: '17 Lydden Rd, London SW18 4LT',
  start_date: Date.today,
  end_date: Date.today + 30.days,
  creator_id: jane.id,
  band_id: band1.id
)

band_session2.save

puts 'Band session created!'
