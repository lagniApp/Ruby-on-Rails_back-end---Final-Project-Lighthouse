require 'geokit'

class Admin::RestaurantsController < ApplicationController
  include Geokit::Geocoders
  # http_basic_authenticate_with name: ENV['USERADMIN'], password: ENV['PASSWORD']

  # def index
  #   @restaurants = Restaurant.order(id: :desc).all
  # end

  # def new
  #   @restaurant = Restaurant.new
  # end

  def create
    parsed = JSON.parse(request.raw_post)

    params = {
            name: parsed['name'],
            username: parsed['username'],
            email: parsed['email'],
            phone: parsed['phone'],
            password: parsed['password'],
            address: parsed['address'],
            balance: 0
    }
    puts params

    

    puts "SERVER SIDE"
    
    @restaurant = Restaurant.create!(params)
    
    if @restaurant
      get_lat_lng(@restaurant)
      # puts @restaurant.latitude
      render json: @restaurant, status: :created
    else
      render json: {error:'Wrong email or password'}
    end
  end

  # def destroy
  #   @restaurant = Restaurant.find params[:id]
  #   @restaurant.destroy
  #   redirect_to [:admin, :restaurants], notice: 'restaurant deleted!'
  # end

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
        # :longitude, 
        # :latitude
    )
  end

  def get_lat_lng(restaurant)
      coords = GoogleGeocoder.geocode(restaurant.address)
      @restaurant.longitude = coords.lng
      @restaurant.latitude = coords.lat
  end

end
