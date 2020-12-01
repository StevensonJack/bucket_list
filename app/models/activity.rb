class Activity < ApplicationRecord
  CATEGORY = ["Flights", "Experiences"]
  belongs_to :bucket
  has_many :offers, dependent: :destroy
  validates :title, :budget, :location, :time_frame, :people_number, :category, :photo, presence: true

  # after_update :skyscanner_api
  after_create :skyscanner_job
  after_update :skyscanner_job

  private

  def skyscanner_api
    self.offers.delete_all

    country = "United Kingdom"
    currency = "GBP"
    originplace = "London"
    destinationplace = self.location
    leaving_date = (Time.now + 10.days).strftime("%Y-%m-%d")
    return_date = (Time.now + 10.days + self.time_frame.to_i.days).strftime("%Y-%m-%d")

    results = Skyscanner.new(country, currency, originplace, destinationplace, leaving_date, return_date).search_flights

    results.each do |quote|
      offer = Offer.new(rating: 0, price: quote["MinPrice"], start_date: leaving_date, end_date: return_date, origin: quote[:OriginPlace].first["Name"], destination: quote[:DestinationPlace].first["Name"], flight_carrier: quote[:OutboundCarrier].first["Name"])
      offer.activity = self
      offer.save
    end
  end

  def skyscanner_job
    SkyscannerJob.perform_now(self)
  end
end
