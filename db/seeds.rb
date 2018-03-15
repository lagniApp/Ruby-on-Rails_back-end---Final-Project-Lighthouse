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

# generate restaurants

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

total_tags = ['beer', 'wine', 'cocktail', 'pizza', 'food',
  'burrito', 'hamburger', 'pasta', 'sushi', 'steak']
tag_list = []

# generate tags

total_tags.each { |tag, i| newTag = Tag.create!({cuisine: tag})
  tag_list << newTag
}

coupon_list = []

def generate_message
  beginning_deal = "#{Faker::Food.dish} $#{rand(5..10)} off,"
  middle_deal = " #{Faker::Food.dish} $#{rand(5..10)} off,"
  end_deal = "#{Faker::Food.dish} $#{rand(5..10)} off"
  message = ""
  totalMeals = rand(2..4)
  totalMeals.times do |i|
    if i == 0
      message << beginning_deal
    elsif i == totalMeals - 1
      message << end_deal
    else
      message << middle_deal
    end
  end
  return message
end

# generate 20 coupons

20.times do |i|
  random_num = rand(0..4)
  quantity = rand(15..25)
  coup = restaurant_list[random_num].coupons.create!({
    description: generate_message,
    quantity: quantity,
    remaining: quantity
  })
  coupon_list << coup
end

def generate_random_tag (arr)
  random_int = rand(0..9)
  while arr.include?(random_int) do
    random_int = rand(0..9)
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





