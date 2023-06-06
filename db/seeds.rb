# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require "open-uri"
puts "Clearing database... 🧹"

City.destroy_all

puts "Creating users... 👤"

amsterdam = City.create!(name: "Amsterdam", country: "Netherlands", longitude: "4.897070", latitude: "52.377956")
london = City.create!(name: "London", country: "United Kingdom", longitude: "	-0.118092", latitude: "51.509865")
paris = City.create!(name: "Paris", country: "France", longitude: "2.349014", latitude: "48.864716")

puts "Successfully created #{City.count} users"
