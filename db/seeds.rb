require 'faker'

puts "Cleaning database..."
  User.destroy_all
  Bucket.destroy_all
  Activity.destroy_all

puts "Creating users..."
  claudine = User.new(
    name: "Claudine",
    email: "claudine@gmail.com",
    password: "123456",
    location: Faker::Nation.capital_city,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
    )
  claudine.save!

  marta = User.new(
    name: "Marta",
    email: "marta@gmail.com",
    password: "123456",
    location: Faker::Nation.capital_city,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
    )
  marta.save!

  ana = User.new(
  name: "Ana",
  email: "ana@gmail.com",
  password: "123456",
  location: Faker::Nation.capital_city,
  birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
  )
  ana.save!

  jack = User.new(
  name: "Jack",
  email: "jack@gmail.com",
  password: "123456",
  location: Faker::Nation.capital_city,
  birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
  )
  jack.save!

  marjori = User.new(
  name: "Marjori",
  email: "marjori@gmail.com",
  password: "123456",
  location: Faker::Nation.capital_city,
  birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
  )
  marjori.save!

  alicia = User.new(
  name: "Alícia",
  email: "alicia@gmail.com",
  password: "123456",
  location: Faker::Nation.capital_city,
  birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
  )
  alicia.save!

  pepe = User.new(
  name: "Pepe",
  email: "jose@gmail.com",
  password: "123456",
  location: Faker::Nation.capital_city,
  birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
  )
  pepe.save!

users = [claudine, marta, ana, alicia, marjori, jack, pepe]

puts "Creating bucket's..."
users.each do |user|
  rand(1..3).times do
    bucket = Bucket.new(
      title: "My travels",
      user: user
    )
    bucket.save!
    puts "Creating activities..."
    rand(1..8).times do
      city = Faker::Nation.capital_city
      activity = Activity.new(
        title: "Travel to #{city}",
        budget: rand(100..500),
        location: city,
        time_frame: rand(3..20),
        people_number: rand(1..5),
        category: "flights",
        bucket_id: bucket
      )
      activity.save!
    end
  end
end