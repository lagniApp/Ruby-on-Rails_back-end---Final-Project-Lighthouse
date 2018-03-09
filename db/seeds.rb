# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Only run on development (local) instances not on production, etc.
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

restaurant1 = Restaurant.create!({
  name: 'Burger King',
  username: 'Diego',
  email: 'bk@diego.com',
  password: 'password',
  phone: '647-967-1111',
  address: '46 Spadina Ave.',
  longitude: -79.39500357,
  latitude: 43.64480087
})

tag1 = Tag.create!({
  cuisine: 'Pizza'
})

restaurant1 = Restaurant.find_or_create_by! name: 'Burger King'

coupon1 = restaurant1.coupons.create!({
  description: 'Half off large pepperoni pizza',
  quantity: '20',
  remaining: '2011'
})

coupon1.tags << tag1
