require 'geokit'

class RestaurantsController < ApplicationController
  include Geokit::Geocoders
  before_action :set_restaurant, only: [:show, :update, :destroy]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all

    render json: @restaurants
  end

  # GET /restaurants/1
  def show
    render json: @restaurant
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    get_lat_lng(@restaurant)
    puts @restaurant

    if @restaurant.save
      render json: @restaurant, status: :created, location: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def restaurant_params
      params.permit(
        :name, 
        :username, 
        :email, 
        :password, 
        :phone, 
        :address, 
        :balance, 
        :longitude, 
        :latitude
        )
    end

    def get_lat_lng(restaurant)
        coords = GoogleGeocoder.geocode(restaurant.address)
        @restaurant.latitude = coords.lat
        @restaurant.longitude = coords.lng
    end
end
