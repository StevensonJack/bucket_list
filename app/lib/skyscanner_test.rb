require_relative 'skyscanner.rb'

country = "US"
currency = "USD"
originplace = "SFO-sky"
destinationplace = "JFK-sky"
outboundpartialdate = "2020-11-20"
inboundpartialdate = "2020-11-27"

results = Skyscanner.new(country, currency, originplace, destinationplace, outboundpartialdate, inboundpartialdate).search_flights

puts results

# rails runner app/lib/skyscanner_test.rb
