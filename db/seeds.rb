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

restaurant_list = []
restaurant_location = [{:latitude => 43.653908, :longitude => -79.384293},
  {:latitude => 43.642509, :longitude => -79.387039},
  {:latitude => 43.644966, :longitude => -79.396751},
  {:latitude => 43.648539, :longitude => -79.395937},
  {:latitude => 34.412382, :longitude => -80.350175}]


5.times do |i|
  restaurant =  Restaurant.create!({
      name: Faker::Superhero.name,
      username: Faker::Name.first_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password(8),
      phone: Faker::PhoneNumber.cell_phone,
      address: Faker::Address.street_address,
      balance: rand(25...60),
      longitude: restaurant_location[i][:longitude],
      latitude: restaurant_location[i][:latitude]
      })
  restaurant_list << restaurant
end


# restaurant1 = Restaurant.create!({
#   name: 'Burger King',
#   username: 'Diego',
#   email: 'bk@diego.com',
#   password: 'password',
#   phone: '6479671111',
#   address: '46 Spadina Ave.',
#   balance: 49,
#   longitude: -79.39500357,
#   latitude: 43.64480087
# })

# restaurant2 = Restaurant.create!({
#   name: "Cibo",
#   username: "CiboKing",
#   email: "cibo@google.com",
#   password: "123456789",
#   phone: "6478799876",
#   address: "522 King St W, Toronto, ON M5V 1L7",
#   balance: 30,
#   longitude: -79.3974043,
#   latitude: 43.6452414
# })

# restaurant3 = Restaurant.create!({
#   name: "Scaramouche",
#   username: "scaramouche",
#   email: "scara@google.com",
#   password: "123456789",
#   phone: "8726481118",
#   address: "1 Benvenuto Pl, Toronto, ON M4V 2L1",
#   balance: 35,
#   longitude: -79.4002503,
#   latitude: 43.6814114,
# })


# tag1 = Tag.create!({
#   cuisine: 'Pizza'
# })
# tag2 = Tag.create!({
#   cuisine: 'Burrito'
# })
# tag3 = Tag.create!({
#   cuisine: 'Hamburger'
# })
# tag4 = Tag.create!({
#   cuisine: 'Wine'
# })

taglist = ['beer', 'wine', 'cocktail', 'pizza', 'food',
  'burrito', 'hamburger', 'pasta', 'sushi', 'steak']




# # 20.times do
# #   Product.create!(
# #     name: Faker::Commerce.product_name,
# #     price: rand(20000) / 100.00,
# #     quantity: rand(100)
# #   )
# # end

# restaurant1 = Restaurant.find_or_create_by! name: 'Burger King'

# coupon1 = restaurant1.coupons.create!({
#   description: 'Half off large pepperoni pizza',
#   quantity: '20',
#   remaining: '2011'
# })
# coupon2 = restaurant2.coupons.create!({
#   description: 'More beer for less!',
#   quantity: '10',
#   remaining: '2011'
# })
# coupon3 = restaurant3.coupons.create!({
#   description: 'Wine',
#   quantity: '30',
#   remaining: '2011'
# })

# coupon1.tags << tag1
# coupon1.tags << tag2
# coupon2.tags << tag3
# coupon2.tags << tag4
# coupon3.tags << tag1
# coupon3.tags << tag4
