# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"

filepath = "/Users/BrendanDodd/code/brendodd/PerriPlan/db/hotels/ams_hotels.json"
serialized_hotel = File.read(filepath)
info = JSON.parse(serialized_hotel)

info['properties'].each do |property|
  puts property['name']
end
