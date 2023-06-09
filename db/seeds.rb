require "json"
require "open-uri"

puts "Clearing database... 🧹"
City.destroy_all
Hotel.destroy_all
Restaurant.destroy_all
Attraction.destroy_all

filepath = File.join(__dir__, "hotels/ams_hotels.json")
serialized_hotel = File.read(filepath)
info = JSON.parse(serialized_hotel)

puts "Creating hotels... 🏨"

info['properties'].each do |property|
  id = property["id"]

  hotel_file_path = File.join(__dir__, "amsterdam_hotels/#{id}")
  hotel_info_serialized = File.read(hotel_file_path)
  hotel_info = JSON.parse(hotel_info_serialized)
  location = hotel_info["summary"]["location"]["address"]["addressLine"]
  price_rating = hotel_info["summary"]["overview"]["propertyRating"]["rating"]
  image_urls = hotel_info["propertyGallery"]["images"][0..4]
  # image_url = image_url["image"]["url"]
  image_url = image_urls.map do |image_url|
    image_url["image"]["url"]
  end

  longitude = hotel_info["summary"]["location"]["coordinates"]["longitude"]
  latitude = hotel_info["summary"]["location"]["coordinates"]["latitude"]

  Hotel.create({ name: property['name'], location: location, price_rating: price_rating, image_url: image_url, longitude: longitude, latitude: latitude })
end

puts "Successfully created #{Hotel.count} hotels"

puts "Creating cities... 🌆"

City.create!(name: "Amsterdam", country: "Netherlands", latitude: "52.377956", longitude: "4.897070")
City.create!(name: "London", country: "United Kingdom", latitude: "51.509865", longitude: "-0.118092")
City.create!(name: "Barcelona", country: "Spain", latitude: "41.3851", longitude: "2.1734")
City.create!(name: "Berlin", country: "Germany", latitude: "52.5200", longitude: "13.4050")
City.create!(name: "New Orleans", country: "Louisiana", latitude: "29.9511", longitude: "90.0715")
City.create!(name: "New York", country: "New York", latitude: "40.7128", longitude: "74.0060")

puts "Successfully created #{City.count} cities"

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

puts "Creating restaurants... 🍽️"

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/7a6d55f9-c6a8-4358-80c2-c46ba7356eac/6b1470b3-499c-4a7a-9e39-106b632e5556.jpg")
eighty_four = Restaurant.new(name: "Eighty Four", location: "Oranje-Vrijstaatkade 25, 1093 KS, Amsterdam", price_rating: 8.9)
eighty_four.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
eighty_four.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/1f1858d8-6137-4e37-a1b2-2fa1c6014b73/5c5bc1db-a402-4a09-a42b-6cfb2f02227f.jpg")
frenzi = Restaurant.new(name: "Frenzi", location: "Zwanenburgwal 232, 1011 JH, Amsterdam", price_rating: 8.7)
frenzi.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
frenzi.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/f95707d2-be47-491c-b1c1-6afa043941c7/ed548fc9-8f06-4c4c-89c9-f14aba8606f4.jpg")
tashi_deleg = Restaurant.new(name: "Tashi Deleg ", location: "Utrechtsestraat 65, 1017 VJ, Amsterdam", price_rating: 8.9)
tashi_deleg.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
tashi_deleg.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/c12a33a0-988a-47bb-b305-6946b5afb214/4627ef2a-50e5-4d0d-9ba0-a9cb0f1aa103.jpg")
piccolino = Restaurant.new(name: "Piccolino", location: "Lange Leidsedwarsstraat 63-65, 1017 NH, Amsterdam", price_rating: 8.9)
piccolino.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
piccolino.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/0124ef26-9bb1-42c5-82c8-9c8b03b457b1/b0e6c4cc-760b-40ee-90cc-2bed7fd661e1.jpg")
jack_dish = Restaurant.new(name: "Jack Dish ", location: "Stadionplein 19, 1076 CG, Amsterdam", price_rating: 8.9)
jack_dish.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
jack_dish.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/3cf01f99-2a0d-4a48-9fa1-90aab1fb18e5/a76d0090-c55c-422a-b853-044051255ead.jpg")
burrito = Restaurant.new(name: "Burrito", location: "De Clerqstraat 141, 1052 ND, Amsterdam", price_rating: 9.1)
burrito.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
burrito.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/4f8dfab9-e28a-49e3-b3ee-fd68ee8b9007/580d9846-e217-4654-91a0-7f1137a8f487.jpg")
la_vaca = Restaurant.new(name: "La Vaca", location: "Thorbeckeplein 11-13, 10-17 CS, Amsterdam", price_rating: 8.2)
la_vaca.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
la_vaca.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/52b7c7cc-ecc3-4395-b748-6255cea92044/89aafd76-0607-493a-a134-ee7372e5a6b1.jpg")
kafe_kuyl = Restaurant.new(name: "Kafé Kuyl ", location: "Rembrandtplein 26, 1017 CV Amsterdam", price_rating: 8.3)
kafe_kuyl.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
kafe_kuyl.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/88fbda01-a571-4916-a468-921ea64ca8b3/8e6bfe5f-b246-4076-9d91-c8ecdd622d13.jpg")
kagetsu = Restaurant.new(name: "Kagetsu", location: "Hartenstraat 17, 1016, Amsterdam", price_rating: 8.6)
kagetsu.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
kagetsu.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/ca77f79c-fe60-4e8e-aaf6-cf1ca885a1c5/14dfa3aa-a9b8-4823-b181-b86431aad9db.jpg")
apostrof = Restaurant.new(name: "Apostrof", location: "Planciusstraat 49, 1013 ME, Amsterdam", price_rating: 9.3)
apostrof.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
apostrof.save

puts "Successfully created #{Restaurant.count} restaurants"
