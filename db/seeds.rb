require 'faker'
require 'unsplash'

# Call Unsplash API
def search_bucket_photo(search_for)
  photo = nil
  while photo.nil?
    photo = Unsplash::Photo.search("#{search_for}")[rand(0..10)]
  end
  return photo
end

def search_activity
  photo = nil
  while photo.nil?
    city = Faker::Nation.capital_city
    photo = Unsplash::Photo.search("#{city}")[rand(0..5)]
  end
  return {city: city, photo: photo}
end

puts "Cleaning database..."
  User.destroy_all
  Bucket.destroy_all
  Activity.destroy_all
puts "Database cleanded!"

puts "Creating users..."
  # User name array
user_name = ['Claudine', 'Ana', 'Marjori', 'Alicia', 'Marta', 'Jack', 'Pepe']

user_name.each do |name| 
  # Creating user
  user = User.new(
    name: name,
    email: "#{name}@gmail.com",
    password: "123456",
    location: Faker::Nation.capital_city,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
  )
  user.save!
  puts "#{user.name} created!"

  # Write the title of the bucket and the title of their activities. Keep in mind that the activities will take place in different cities, ex: "Travel to Singapore"
  # titles = { "Bucket title" => "Activities title" }
  titles = { "Flight" => "Flight to", "Food" => "Taste food from"}
  
  # Creating buckets
  puts "Adding buckets to #{user.name}..."
  titles.each do |bucket_title, activity_title| 
    photo = search_bucket_photo(bucket_title)
    bucket = Bucket.new(
    title: bucket_title,
    user: user,
    photo: photo.urls.regular
    )
    bucket.save!
    puts "#{bucket.title} created!"

    # Creating activities
    puts "Adding activities to #{bucket.title}..."
    rand(3..8).times do
      data = search_activity
      activity = Activity.new(
        title: "#{activity_title}" + " #{data[:city]}",
        budget: rand(100..500),
        location: data[:city],
        time_frame: rand(3..20),
        people_number: rand(1..5),
        category: Activity::CATEGORY[0],
        photo: data[:photo].urls.regular,
        bucket: bucket
      )
      activity.save!
      puts "#{activity.title} created!"
    end
  end
end
