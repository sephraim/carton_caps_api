User.destroy_all

User.create!([
  {
    first_name: 'Lisa',
    last_name: 'Simpson',
    birthdate: Date.new(1981, 5, 9),
    zip_code: '55112',
    referral_code: 'XY7G4D'
  }
])

puts "Created #{User.count} user(s) in the #{Rails.env.downcase} database"