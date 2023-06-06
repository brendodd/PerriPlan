require "json"
require "open-uri"

puts "Clearing database... 🧹"

City.destroy_all
Hotel.destroy_all

filepath = "/Users/BrendanDodd/code/brendodd/PerriPlan/db/hotels/ams_hotels.json"
serialized_hotel = File.read(filepath)
info = JSON.parse(serialized_hotel)

puts "Creating hotels... 🏨"

info['properties'].each do |property|
  Hotel.create({ name: property['name'] })
end

puts "Successfully created #{Hotel.count} hotels"

puts "Creating users... 👤"

amsterdam = City.create!(name: "Amsterdam", country: "Netherlands", latitude: "52.377956", longitude: "4.897070")
london = City.create!(name: "London", country: "United Kingdom", latitude: "51.509865", longitude: "-0.118092")
paris = City.create!(name: "Paris", country: "France", latitude: "48.864716", longitude: "2.349014")

puts "Successfully created #{City.count} users"

puts "Creating attractions... 🎡"

Attraction.create(name: 'Amsterdam Boat Adventures', location: 'Nieuwe Keizersgracht 1, 1018 DS Amsterdam', price_rating: '€€')
Attraction.create(name: 'Westerpark', location: '', price_rating: '€')
Attraction.create(name: 'Vondelpark', location: '', price_rating: '€')
Attraction.create(name: 'Rembrandtpark', location: '', price_rating: '€')
Attraction.create(name: 'Van Stapele', location: 'Heisteeg 4, 1012 WC Amsterdam', price_rating: '€')
Attraction.create(name: 'Pllek', location: 'T.T. Neveritaweg 59, 1033 WB Amsterdam', price_rating: '€€')
Attraction.create(name: 'Oosterpark', location: '', price_rating: '€')
Attraction.create(name: 'Flevopark', location: '', price_rating: '€')
Attraction.create(name: 'Beatrixpark', location: '', price_rating: '€')
Attraction.create(name: 'Noorderlicht Cafe', location: 'NDSM-Plein 102, 1033 WB Amsterdam', price_rating: '€€')

puts "Successfully created #{Attraction.count} attractions"
