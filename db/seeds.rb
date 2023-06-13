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

  hotel = Hotel.create({ name: property['name'], location: location, price_rating: price_rating, image_url: image_url, longitude: longitude, latitude: latitude })

  # get the amenity info from json
  amenities_items = hotel_info["summary"]["amenities"]["topAmenities"]["items"]
  # make an array of strings of amenities
  amenities_array = amenities_items.map do |amenity|
    amenity["text"]
  end
  # @user.tag_list.add("awesome", "slick")
  hotel.tag_list.add(amenities_array)
  # hotel.save
  hotel.save
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

file = URI.open('https://images.unsplash.com/photo-1610899732513-b09a9513f1f1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8YW1zdGVyZGFtJTIwYm9hdCUyMHJpZGVzfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60')
amsterdam_boat_adventures = Attraction.new(name: 'Amsterdam Boat Adventures', location: 'Nieuwe Keizersgracht 1, 1018 DS Amsterdam', latitude: '52.365952', longitude: '4.915319', price_rating: '€€')
amsterdam_boat_adventures.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
amsterdam_boat_adventures.save

file = URI.open('https://images.unsplash.com/photo-1664958833011-e0a8142a671e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2VzdGVycGFya3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60')
westerpark = Attraction.new(name: 'Westerpark', location: 'Amsterdam, NL', latitude: '52.3875', longitude: '4.8778', price_rating: '€')
westerpark.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
westerpark.save

file = URI.open('https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0c/bf/7b/51/vondelpark.jpg?w=1200&h=1200&s=1')
vondelpark = Attraction.new(name: 'Vondelpark', location: 'Amsterdam, NL', latitude: '52.3580', longitude: '4.8686', price_rating: '€')
vondelpark.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
vondelpark.save

file = URI.open('https://media.istockphoto.com/id/1296182365/photo/sun-shining-through-the-trees-in-rembrandtpark-amsterdam-during-sunrise.webp?b=1&s=170667a&w=0&k=20&c=X_DnnB4bTwtrgRQpjnYjgQ07XXHMRrAp0fOeV0tk98I=')
rembrandtpark = Attraction.new(name: 'Rembrandtpark', location: 'Postjesweg, Amsterdam', latitude: '52.3657', longitude: '4.8403', price_rating: '€')
rembrandtpark.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
rembrandtpark.save

file = URI.open('https://media.istockphoto.com/id/1262883795/photo/van-stapele-cookie-with-white-chocolate-in-plate-ready-to-serve-and-eat.webp?b=1&s=170667a&w=0&k=20&c=a7ACBL7Aqjx4C0h_6k2vkqcUbEPejohcdsApfSxDjDY=')
van_stapele = Attraction.new(name: 'Van Stapele', location: 'Heisteeg 4, 1012 WC Amsterdam', latitude: '52.3756', longitude: '4.8946', price_rating: '€')
van_stapele.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
van_stapele.save

file = URI.open('https://images.unsplash.com/photo-1508028209469-933de69c0f1e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGxsZWt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60')
pllek = Attraction.new(name: 'Pllek', location: 'T.T. Neveritaweg 59, 1033 WB Amsterdam', latitude: '52.4063', longitude: '4.8929', price_rating: '€€')
pllek.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
pllek.save

file = URI.open('https://images.unsplash.com/photo-1636129986077-a1fa28e86afc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG9vc3RlcnBhcmt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60')
oosterpark = Attraction.new(name: 'Oosterpark', location: 'Oosterpark, 1012 AA Amsterdam', latitude: '52.3608', longitude: '4.9212', price_rating: '€')
oosterpark.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
oosterpark.save

file = URI.open('https://media.istockphoto.com/id/1437236291/photo/flevopark-in-amsterdam-in-autumn.webp?b=1&s=170667a&w=0&k=20&c=qmQHPm1O8NxOK6oCjv4HnXvalJRcTlTEdOm-ZNFKXpc=')
flevopark = Attraction.new(name: 'Flevopark', location: 'Valentijnkade, 1098 XA Amsterdam', latitude: '52.3580', longitude: '4.9423', price_rating: '€')
flevopark.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
flevopark.save

file = URI.open('https://images.unsplash.com/photo-1531421980559-58e6d1eca29e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdHJpeHBhcmt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60')
beatrixpark = Attraction.new(name: 'Beatrixpark', location: 'Diepenbrockstraat 21, 1077 VX Amsterdam', latitude: '52.3409', longitude: '4.8745', price_rating: '€')
beatrixpark.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
beatrixpark.save

file = URI.open('https://images.unsplash.com/photo-1521017432531-fbd92d768814?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Tm9vcmRlcmxpY2h0JTIwQ2FmZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60')
noorderlicht_cafe = Attraction.new(name: 'Noorderlicht Cafe', location: 'NDSM-Plein 102, 1033 WB Amsterdam', latitude: '52.3997', longitude: '4.8959', price_rating: '€€')
noorderlicht_cafe.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
noorderlicht_cafe.save

puts "Successfully created #{Attraction.count} attractions"

puts "Creating restaurants... 🍽️"

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/7a6d55f9-c6a8-4358-80c2-c46ba7356eac/6b1470b3-499c-4a7a-9e39-106b632e5556.jpg")
eighty_four = Restaurant.new(name: "Eighty Four", latitude: '52.361191', longitude: '4.927835', location: "Oranje-Vrijstaatkade 25, 1093 KS, Amsterdam", price_rating: 8.9)
eighty_four.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
eighty_four.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/1f1858d8-6137-4e37-a1b2-2fa1c6014b73/5c5bc1db-a402-4a09-a42b-6cfb2f02227f.jpg")
frenzi = Restaurant.new(name: "Frenzi", latitude: '52.367745', longitude: '4.901861', location: "Zwanenburgwal 232, 1011 JH, Amsterdam", price_rating: 8.7)
frenzi.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
frenzi.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/f95707d2-be47-491c-b1c1-6afa043941c7/ed548fc9-8f06-4c4c-89c9-f14aba8606f4.jpg")
tashi_deleg = Restaurant.new(name: "Tashi Deleg ", latitude: '52.363678', longitude: '4.893603', location: "Utrechtsestraat 65, 1017 VJ, Amsterdam", price_rating: 8.9)
tashi_deleg.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
tashi_deleg.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/c12a33a0-988a-47bb-b305-6946b5afb214/4627ef2a-50e5-4d0d-9ba0-a9cb0f1aa103.jpg")
piccolino = Restaurant.new(name: "Piccolino", latitude: '52.364503', longitude: '4.881366', location: "Lange Leidsedwarsstraat 63-65, 1017 NH, Amsterdam", price_rating: 8.9)
piccolino.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
piccolino.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/0124ef26-9bb1-42c5-82c8-9c8b03b457b1/b0e6c4cc-760b-40ee-90cc-2bed7fd661e1.jpg")
jack_dish = Restaurant.new(name: "Jack Dish ", latitude: '52.345686', longitude: '4.860191', location: "Stadionplein 19, 1076 CG, Amsterdam", price_rating: 8.9)
jack_dish.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
jack_dish.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/3cf01f99-2a0d-4a48-9fa1-90aab1fb18e5/a76d0090-c55c-422a-b853-044051255ead.jpg")
burrito = Restaurant.new(name: "Burrito", latitude: '52.372553', longitude: '4.871809', location: "De Clerqstraat 141, 1052 ND, Amsterdam", price_rating: 9.1)
burrito.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
burrito.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/4f8dfab9-e28a-49e3-b3ee-fd68ee8b9007/580d9846-e217-4654-91a0-7f1137a8f487.jpg")
la_vaca = Restaurant.new(name: "La Vaca", latitude: '52.365572', longitude: '4.895689', location: "Thorbeckeplein 11-13, 10-17 CS, Amsterdam", price_rating: 8.2)
la_vaca.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
la_vaca.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/52b7c7cc-ecc3-4395-b748-6255cea92044/89aafd76-0607-493a-a134-ee7372e5a6b1.jpg")
kafe_kuyl = Restaurant.new(name: "Kafé Kuyl ", latitude: '52.366432', longitude: '4.893904', location: "Rembrandtplein 26, 1017 CV Amsterdam", price_rating: 8.3)
kafe_kuyl.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
kafe_kuyl.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/88fbda01-a571-4916-a468-921ea64ca8b3/8e6bfe5f-b246-4076-9d91-c8ecdd622d13.jpg")
kagetsu = Restaurant.new(name: "Kagetsu", latitude: '52.373319', longitude: '4.882193', location: "Hartenstraat 17, 1016, Amsterdam", price_rating: 8.6)
kagetsu.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
kagetsu.save

file = URI.open("https://res.cloudinary.com/tf-lab/image/upload/w_414,h_324,c_fill,q_auto,f_auto,g_auto/restaurant/ca77f79c-fe60-4e8e-aaf6-cf1ca885a1c5/14dfa3aa-a9b8-4823-b181-b86431aad9db.jpg")
apostrof = Restaurant.new(name: "Apostrof", latitude: '52.385898', longitude: '4.882940', location: "Planciusstraat 49, 1013 ME, Amsterdam", price_rating: 9.3)
apostrof.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
apostrof.save

puts "Successfully created #{Restaurant.count} restaurants"

puts "creating bookings..."

Booking.destroy_all

5.times do |index|
  Booking.create!(start_time: Faker::Time.between_dates(from: Date.today + 5, to: Date.today + 10, period: :afternoon).beginning_of_hour,
                  end_time: Faker::Time.between_dates(from: Date.today + 6, to: Date.today + 11, period: :morning).beginning_of_hour,
                  status: ["pending", "confirmed"].sample,
                  note: "hello",
                  bookable: Hotel.all.sample,
                  user: User.all.sample)
  end


  5.times do |index|
    start_time = Faker::Time.between_dates(from: Date.today + 5, to: Date.today + 10, period: :night).beginning_of_hour
    rest_end_time = start_time + 2.hours
    Booking.create!(start_time: start_time,
                    end_time: rest_end_time,
                    status: ["pending", "confirmed"].sample,
                    note: "hello",
                    bookable: Restaurant.all.sample,
                    user: User.all.sample)
    end

puts "Successfully created #{Booking.count} bookings"
