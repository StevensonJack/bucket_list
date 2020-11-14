require 'uri'
require 'net/http'
require 'openssl'
require 'json'

# # This is a json string you want to convert this is to a ruby object
# # Make a method that will do this
# # create a ruby class that handles all the skyscanner stuff
# # include skyscanner.rb later in the project
# # use it like a controller
# # Skyscanner class just returns a hash - which is parsed into another class which converts it into ruby model.
# # Rails tasks - lectures
# # looks through all activities then does the search on skyscanner
# # create skyscanner class - interface it exposes (public methods available) -


class Skyscanner
  def initialize(country, currency, originplace, destinationplace, outboundpartialdate, inboundpartialdate)
    @country = country.to_s
    @currency = currency.to_s
    @originplace = originplace.to_s
    @destinationplace = destinationplace.to_s
    @outboundpartialdate = outboundpartialdate.to_s
    @inboundpartialdate = inboundpartialdate.to_s
  end

  def search_flights
    url = URI("https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/"\
      "#{@country}/"\
      "#{@currency}/"\
      "en-US/"\
      "#{@originplace}/"\
      "#{@destinationplace}/"\
      "#{@outboundpartialdate}"\
      "?inboundpartialdate=#{@inboundpartialdate}"\
    )

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    # request["x-rapidapi-key"] = '32f39adbe2msh15758a51bf6f752p1f5e10jsndba510cf39fc'
    request["x-rapidapi-key"] = ENV["X_RAPIDAPI_KEY"].to_s
    request["x-rapidapi-host"] = 'skyscanner-skyscanner-flight-search-v1.p.rapidapi.com'
    # initialize the class with the api key

    response = http.request(request)
    parsed_response = JSON.parse(response.read_body)
  end

  private

  def method_name

  end

  def create_session(origin, destination, user_country_code, outbound_date)
  end

end
