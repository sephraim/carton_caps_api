# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Depending on the current Rails env, data gets seeded using one of the following seed files:
#   - db/seeds/development.rb
#   - db/seeds/production.rb
#   - db/seeds/test.rb
load(Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb"))