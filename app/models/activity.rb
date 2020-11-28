class Activity < ApplicationRecord
  CATEGORY = ["Flights", "Experiences"]
  belongs_to :bucket
  has_many :offers, dependent: :destroy
  validates :title, :budget, :location, :time_frame, :people_number, :category, :photo, presence: true

  after_update :skyscanner_api

  private

  def skyscanner_api
    self.offers.delete_all

    country = "United Kingdom"
    currency = "GBP"
    originplace = "London"
    # destinationplace = "Paris"
    destinationplace = self.location
    leaving_date = "2020-11-25"
    return_date = "2020-11-27"

    results = Skyscanner.new(country, currency, originplace, destinationplace, leaving_date, return_date).search_flights

    results.each do |quote|
      offer = Offer.new(rating: 0, price: quote["MinPrice"], start_date: leaving_date, end_date: return_date)
      offer.activity = self
      offer.save
    end
  end
end
