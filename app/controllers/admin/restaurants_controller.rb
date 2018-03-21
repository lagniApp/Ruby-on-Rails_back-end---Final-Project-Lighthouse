require 'geokit'
require 'mailgun'
require 'faker'

class Admin::RestaurantsController < ApplicationController
  include Geokit::Geocoders
  
  def create
    parsed = JSON.parse(request.raw_post)
    puts parsed
    if (parsed['adminUser'])
      if parsed['password'] === ENV['ADMIN_PASSWORD'] || parsed['adminUser'] === 'admin'
        render json: { result: 'sucess' }
      else
        render json: { error: 'wrong' }
      end

    else
      mg_client = Mailgun::Client.new ENV["MAILGUN"]
      
      if parsed['password'] != ""
        params = {
          name: parsed['name'],
          username: parsed['username'],
          email: parsed['email'],
          password: parsed['password'],
          phone: parsed['phone'],
          address: parsed['address'],
          balance: 0
        }
      else
        params = {
          name: parsed['name'],
          username: parsed['username'],
          email: parsed['email'],
          password: Faker::Types.string,
          phone: parsed['phone'],
          address: parsed['address'],
          balance: 0
        }
      end
      
      message_params = {  
        from: 'postmaster@mailgun.lagni.ca',             
        to: params[:email],
        subject: 'Lagni App!',
        text:
          "Thank you #{params[:name]} for join Lagni
                
          For the protection of the restaurants we are reviewing all the requests to join the service by hand
          your username to acess is #{params[:username]} and you password is #{params[:password]}
                
          You can start posting coupons as soon as you want.
                
          A good reminder is that each coupon can be deleted within 10 minutes after the creation
                
          Enjoy!
          "
      }

      mg_client.send_message 'mailgun.lagni.ca', message_params

      puts params
      puts "SERVER SIDE"
      
      @restaurant = Restaurant.new(params)
      get_lat_lng(@restaurant)
      
      if @restaurant.save
        render json: @restaurant, status: :created
      else
        render json: {error:'Wrong email or password'}
      end
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(
        :name, 
        :username, 
        :email, 
        :password, 
        :phone, 
        :address, 
        :balance 
    )
  end

  def get_lat_lng(restaurant)
      coords = GoogleGeocoder.geocode(restaurant.address)
      @restaurant.longitude = coords.lng
      @restaurant.latitude = coords.lat
  end

end
