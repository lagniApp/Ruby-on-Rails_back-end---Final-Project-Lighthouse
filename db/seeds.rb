# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Only run on development (local) instances not on production, etc.

require 'faker'

unless Rails.env.development?
  puts "Development seeds only (for now)!"
  exit 0
end

## PRODUCTS
puts "Destroying tables ..."
Coupon.destroy_all
Restaurant.destroy_all
Tag.destroy_all

puts "Re-creating Restaurants ..."

# generate restaurants

restaurant_list = [
  Restaurant.create!({
    name: 'Le Sélect Bistro',
    username: 'Diego',
    email: 'bk@diego.com',
    password: 'password',
    phone: Faker::PhoneNumber.cell_phone,
    address: '432 Wellington St W, Toronto, ON M5V 1E3',
    balance: 49,
    longitude: -79.3990349,
    latitude: 43.6438895
  }),
  Restaurant.create!({
    name: "Cibo Wine Bar",
    username: "CiboKing",
    email: "cibo@google.com",
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "522 King St W, Toronto, ON M5V 1L7",
    balance: 30,
    longitude: -79.4220807,
    latitude: 43.6405251
  }),
  Restaurant.create!({
    name: "Wahlburgers Toronto",
    username: "scaramouche",
    email: "scara@google.com",
    password: "123456789",
    phone: "8726481118",
    address: "Blue Jays Way, Toronto, ON M5V 2G5",
    balance: 35,
    longitude: -79.4002503,
    latitude: 43.6814114,
  }),
  Restaurant.create!({
    name: "Figo Toronto",
    username: "scaramouche",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "295 Adelaide St W, Toronto, ON M5V 1P7",
    balance: 35,
    longitude: -79.3934346,
    latitude: 43.6466882,
  }),
  Restaurant.create!({
    name: "Gusto 101",
    username: "scaramouche",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "101 Portland St, Toronto, ON M5V 2N3",
    balance: 35,
    longitude: -79.400712,
    latitude: 43.6444597,
  }),
  Restaurant.create!({
    name: "The Citizen",
    username: "scaramouche",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "522 King St W, Toronto, ON M5V 1K4",
    balance: 35,
    longitude: -79.3993313,
    latitude: 43.6453238,
  }),
  Restaurant.create!({
    name: "PAI",
    username: "scaramouche",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "18 Duncan St, Toronto, ON M5H 3G8",
    balance: 35,
    longitude: -79.3904049,
    latitude: 43.64683,
  }),
  Restaurant.create!({
    name: "Wide Open",
    username: "CiboKing",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "139A Spadina Ave, Toronto, ON M5V 2L7",
    balance: 30,
    longitude: -79.3977877,
    latitude: 43.6475849
  }),
  Restaurant.create!({
    name: "Rodney’s Oyster House",
    username: "CiboKing",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "469 King St W, Toronto, ON M5V 1K4",
    balance: 30,
    longitude: -79.3977877,
    latitude: 43.6475849
  }),

  Restaurant.create!({
    name: "Luckee",
    username: "CiboKing",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "328 Wellington St W, Toronto, ON M5V 3T4",
    balance: 30,
    longitude: -79.394848,
    latitude: 43.6461641
  }),

  Restaurant.create!({
    name: "Macho Tex Mex Radio Bar",
    username: "CiboKing",
    email: Faker::Internet.email,
    password: "123456789",
    phone: Faker::PhoneNumber.cell_phone,
    address: "92 Fort York Blvd, Toronto, ON M5V 4A7",
    balance: 30,
    longitude: -79.3993326,
    latitude: 43.6394405
  })
]

# generate tags

total_tags = ['beer', 'wine', 'cocktail', 'pizza',
  'burrito', 'hamburger', 'pasta', 'sushi', 'steak']
tag_list = []

total_tags.each { |tag, i| newTag = Tag.create!({cuisine: tag})
  tag_list << newTag
}

# generate coupons

coupon_list = []

# coupons that expired Oct

80.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2017, 10, 15)

  })
  coupon_list << coup
end

# coupons that expired Nov

114.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2017, 11, 15)

  })
  coupon_list << coup
end

# coupons that expired Dec

150.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2017, 12, 15)

  })
  coupon_list << coup
end

# coupons that are expired Jan

220.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 1, 15)

  })
  coupon_list << coup
end

# coupons that are expired Feb
  # Feb 1
60.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 2, 1)

  })
  coupon_list << coup
end
  # Feb 8
80.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 2, 8)

  })
  coupon_list << coup
end
  # Feb 15
90.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 2, 15)

  })
  coupon_list << coup
end
  # Feb 22
73.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 2, 22)

  })
  coupon_list << coup
end

# coupons that are expired March
  # March 1
88.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 3, 1)

  })
  coupon_list << coup
end
  # March 8
101.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 3, 8)

  })
  coupon_list << coup
end
  # March 15
121.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: true,
    expiration_time: Time.new(2018, 3, 1)

  })
  coupon_list << coup
end

# coupons that are valid

15.times do |i|
  random_num = rand(0..10)
  quantity = rand(15..25)
  remaining = rand(1..quantity)
  time = Time.now + 9.hours
  coup = restaurant_list[random_num].coupons.create!({
    description: "#{Faker::Food.dish} $#{rand(5..10)} off",
    quantity: quantity,
    remaining: remaining,
    expired: false,
    expiration_time: time
  })
  coupon_list << coup
end

def generate_random_tag (arr)
  random_int = rand(0..8)
  while arr.include?(random_int) do
    random_int = rand(0..8)
  end
  arr << random_int
end

coupon_list.each { |coupon, i|
  arr = []
  rand(1..4).times do
    generate_random_tag(arr)
  end
  arr.each { |val, index|
    coupon.tags << tag_list[val]
  }
}





