namespace :activity do
  desc "Pulling skyscanner offers via the API"
  task update_offers: :environment do
    activities = Activity.all
    puts "Enqueuing update of #{activities.size} activities"
    activities.each do |activity|
      SkyscannerJob.perform_later(activity)
    end
  end
end
