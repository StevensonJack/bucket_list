require_relative 'skyscanner.rb'

country = "US"
currency = "USD"
originplace = "San Francisco"
destinationplace = "New York JFK"
outboundpartialdate = "2020-11-20"
inboundpartialdate = "2020-11-27"

results = Skyscanner.new(country, currency, originplace, destinationplace, outboundpartialdate, inboundpartialdate).search_flights

# results = Skyscanner.new(country, currency, originplace, destinationplace, outboundpartialdate, inboundpartialdate).get_place_id("New York JFK")

# results = Skyscanner.new(country, currency, originplace, destinationplace, outboundpartialdate, inboundpartialdate).get_country_code("United States")

puts results

# puts results["Quotes"][0]
# puts results["Carriers"]

# rails runner app/lib/skyscanner_test.rb
