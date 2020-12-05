class Offer < ApplicationRecord
  belongs_to :activity

  after_save :activity_rating

  private

  def activity_rating
    # Calculate the activity rating
    best_offer = activity.offers.order(price: :asc).first
    rating = best_offer.price / activity.budget

    # TODO: UPDATE CODE BECAUSE ONLY THE RATING CHANGE WHEN THE RATING IS BETTER
    # If the rating is better than the actaul rating save it
    if activity.rating.blank? || activity.rating > rating
      activity.rating = rating
      activity.save
    end
  end
end
