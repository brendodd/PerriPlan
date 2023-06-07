require 'json'
require 'uri'
require 'net/http'

filepath = File.join(__dir__, 'ams_hotels.json')
info = JSON.parse(File.read(filepath))

ids = info['properties'].map { |property| property['id'] }

 ids.each do |id|
  url = URI("https://hotels-com-provider.p.rapidapi.com/v2/hotels/details?domain=AE&locale=en_GB&hotel_id=#{id}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Key"] = '3a3fb97506msh8b49abdff28130fp180f5bjsn82a2b01e5bad'
  request["X-RapidAPI-Host"] = 'hotels-com-provider.p.rapidapi.com'

  response = http.request(request)
  content = response.read_body
  File.write("#{id}", content)



  # open a file with "#{id}.rb"
  # write the response body into that file save

end
#puts ids
