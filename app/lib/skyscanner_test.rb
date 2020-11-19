require 'uri'
require 'net/http'
require 'openssl'
# require 'json'
require 'byebug'
require 'unirest'
require_relative 'skyscanner.rb'


country = "United Kingdom"
currency = "GBP"
originplace = "London"
destinationplace = "Paris"
outboundpartialdate = "2020-11-22"
inboundpartialdate = "2020-11-23"

results = Skyscanner.new(country, currency, originplace, destinationplace, outboundpartialdate, inboundpartialdate).search_flights

# puts results

results.each do |x|
  puts x
end

# get_carrier_by_id method that can get the full object

# fetch all the quotes and then from there exchange the info to get the strings rather than id

# quote_data_gather method

# within outbound_carrier: { put the carrier hash}

# rails runner app/lib/skyscanner_test.rb
