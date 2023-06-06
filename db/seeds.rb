require "json"
require "open-uri"

puts "Clearing database... 🧹"

City.destroy_all

filepath = "/Users/BrendanDodd/code/brendodd/PerriPlan/db/hotels/ams_hotels.json"
serialized_hotel = File.read(filepath)
info = JSON.parse(serialized_hotel)

info['properties'].each do |property|
  Hotel.create({ name: property['name'] })
end

puts "Creating users... 👤"

amsterdam = City.create!(name: "Amsterdam", country: "Netherlands", longitude: "4.897070", latitude: "52.377956")
london = City.create!(name: "London", country: "United Kingdom", longitude: "	-0.118092", latitude: "51.509865")
paris = City.create!(name: "Paris", country: "France", longitude: "2.349014", latitude: "48.864716")

puts "Successfully created #{City.count} users"
