class Skyscanner
  def initialize(country, currency, originplace, destinationplace, outboundpartialdate, inboundpartialdate)
    @currency = currency.to_s
    @outboundpartialdate = outboundpartialdate.to_s
    @inboundpartialdate = inboundpartialdate.to_s

    @country = get_country_code(country).to_s
    @originplace = get_place_id(originplace).to_s
    @destinationplace = get_place_id(destinationplace).to_s
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

    response = http(url).request(request(url))
    # JSON.parse(response.read_body)
    gather_quote_data(JSON.parse(response.read_body))
  end

  private

  def get_place_id(location)
    url = URI("https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/UK/USD/en-GB/?query=#{location}")

    response = http(url).request(request(url))
    places = JSON.parse(response.read_body)["Places"]
    places[0]['PlaceId']
  end

  def get_country_code(country)
    url = URI("https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/reference/v1.0/countries/en-US")

    response = http(url).request(request(url))
    countries = JSON.parse(response.read_body)["Countries"]

    country_code = countries.select {|code| code["Name"] == country}
    country_code.first["Code"]
  end

  def http(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def request(url)
    # Setting the headers
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = '32f39adbe2msh15758a51bf6f752p1f5e10jsndba510cf39fc'
    # request["x-rapidapi-key"] = ENV["X_RAPIDAPI_KEY"].to_s
    request["x-rapidapi-host"] = 'skyscanner-skyscanner-flight-search-v1.p.rapidapi.com'
    request
  end

  def gather_quote_data(results)
    results["Quotes"].each do |quote|
      quote[:OutboundCarrier] = results["Carriers"].select { |x| x["CarrierId"] == quote["OutboundLeg"]["CarrierIds"][0]}
      quote[:OriginPlace] = results["Places"].select { |x| x["PlaceId"] == quote["OutboundLeg"]["OriginId"]}
      quote[:DestinationPlace] = results["Places"].select { |x| x["PlaceId"] == quote["OutboundLeg"]["DestinationId"]}
    end

    results["Quotes"]
  end
end
