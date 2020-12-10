require 'faker'
require 'unsplash'

# Call Unsplash API
def search_bucket_photo(search_for)
  photo = nil
  while photo.nil?
    photo = Unsplash::Photo.search("#{search_for}")
  end
  return photo
end

def search_activity(location)
  photo = nil
  while photo.nil?
    city = location
    photo = Unsplash::Photo.search("#{city}")[rand(0..5)]
  end
  return {city: city, photo: photo}
end

puts "Cleaning database..."
  User.destroy_all
  Bucket.destroy_all
  Activity.destroy_all
puts "Database cleanded!"

puts "Creating user..."

user = User.new(
  name: "Jack",
  email: "jack@gmail.com",
  password: "123456",
  location: "London",
  birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
)

user.save!
puts "#{user.name} created!"

buckets = ["Vacation", "Surfing", "Bands", "Food", "Hiking", "Dance"].reverse
issue_buckets = ["Climbing"]

buckets.each do |bucket_item|
  puts "Adding #{bucket_item} buckets to #{user.name}..."
  bucket = Bucket.new(
    title: bucket_item,
    user: user,
    photo: Unsplash::Photo.search(bucket_item)[0].urls.regular
  )
  bucket.save!
  puts "#{bucket.title} created!"
end

travel_locations = {"Pyramids of Giza": "Egypt", "Christ the Redeemer": "Rio de Janeiro", "Petra": "Jordan", "Colosseum": "Rome", "Great Wall of China": "Beijing"}
problem_locations = {"Taj Mahal": "India"}

puts "Adding activities to #{buckets[0]}..."


travel_locations.each do |title, flight_path|
  # data = search_activity(title)
  photo = Unsplash::Photo.search(title)
  puts "#{title} is #{photo.size}"
  if photo.size > 0
    activity = Activity.new(
      title: title,
      budget: rand(100..500),
      location: flight_path,
      time_frame: rand(3..20),
      people_number: rand(1..5),
      category: Activity::CATEGORY[0],
      photo: Unsplash::Photo.search(title)[0].urls.regular,
      bucket: Bucket.where(title: "Vacation").first
    )
    activity.save!
    puts "#{activity.title} created!"
  else
    puts "#{title} - Unsplash cannot find an image because its a terrible api"
  end
end

surf_locations = {"Surfing in Hanalei Bay": "Hawaii", "Scuba Diving in Red Sea": "Egypt", "Swimming with Dolphins": "Bahamas" }

puts "Adding activities to #{buckets[1]}..."

surf_locations.each do |title, flight_path|
  # data = search_activity(title)
  activity = Activity.new(
    title: title,
    budget: rand(100..500),
    location: flight_path,
    time_frame: rand(3..20),
    people_number: rand(1..5),
    category: Activity::CATEGORY[0],
    photo: Unsplash::Photo.search(title)[1].urls.regular,
    bucket: Bucket.where(title: "Surfing").first
  )
  activity.save!
  puts "#{activity.title} created!"
end


  # User name array
# user_name = ['Jack']

# user_name.each do |name|
#   # Creating user
#   user = User.new(
#     name: "Jack",
#     email: "#{name}@gmail.com",
#     password: "123456",
#     location: "London",
#     birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
#   )
#   user.save!
#   puts "#{user.name} created!"

#   # Write the title of the bucket and the title of their activities. Keep in mind that the activities will take place in different cities, ex: "Travel to Singapore"
#   # titles = { "Bucket title" => "Activities title" }
#   titles = { "Flight" => "Flight to", "Food" => "Taste food from", "Surfing" => "Surf in", "Bands" => "Listen at"}

#   # Creating buckets
#   puts "Adding buckets to #{user.name}..."
#   titles.each do |bucket_title, activity_title|
#     photo = search_bucket_photo(bucket_title)
#     bucket = Bucket.new(
#     title: bucket_title,
#     user: user,
#     photo: photo.urls.regular
#     )
#     bucket.save!
#     puts "#{bucket.title} created!"

#     # Creating activities
#     puts "Adding activities to #{bucket.title}..."
#     rand(3..8).times do
#       data = search_activity
#       activity = Activity.new(
#         title: "#{activity_title}" + " #{data[:city]}",
#         budget: rand(100..500),
#         location: data[:city],
#         time_frame: rand(3..20),
#         people_number: rand(1..5),
#         category: Activity::CATEGORY[0],
#         photo: data[:photo].urls.regular,
#         bucket: bucket
#       )
#       activity.save!
#       puts "#{activity.title} created!"
#     end
#   end
# end
