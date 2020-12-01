class SkyscannerJob < ApplicationJob
  queue_as :default

  def perform(activity)
    activity.offers.delete_all

    country = "United Kingdom"
    currency = "GBP"
    originplace = "London"
    destinationplace = activity.location
    leaving_date = (Time.now + 10.days).strftime("%Y-%m-%d")
    return_date = (Time.now + 10.days + activity.time_frame.to_i.days).strftime("%Y-%m-%d")

    results = Skyscanner.new(country, currency, originplace, destinationplace, leaving_date, return_date).search_flights

    results.each do |quote|
      offer = Offer.new(rating: 0, price: quote["MinPrice"], start_date: leaving_date, end_date: return_date, origin: quote[:OriginPlace].first["Name"], destination: quote[:DestinationPlace].first["Name"], flight_carrier: quote[:OutboundCarrier].first["Name"])
      offer.activity = activity
      offer.save
    end
  end
end
