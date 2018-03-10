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
    @meetup_params = meetup_params(@restaurant)
    @meets = meetup_api(@meetup_params)
    @restaurant.meetups = @meets

    render json: @restaurant
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    get_lat_lng(@restaurant)
    
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
        @restaurant.longitude = coords.lng
        @restaurant.latitude = coords.lat
    end

    def meetup_params(restaurant)
      meetup_params = { 
        lon: restaurant.longitude, 
        lat: restaurant.latitude, 
        radius: 1, 
        status: 'upcoming', 
        format: 'json', 
        page: '500'
      }
    end

    def meetup_api(meetup_params)
      i = 0
      meetups_arr = []
      @events = MeetupApi.new.open_events(meetup_params)
      while (i < 200) do
        if @events["results"][i] == nil
          return meetups_arr
        end
        if 
          @events["results"][i]["yes_rsvp_count"] > 30 &&
          @events["results"][i]["name"] != @events["results"][i-1]["name"]
          
          meetups_arr.push({
            name: @events["results"][i]["name"],
            ppl_yes: @events["results"][i]["yes_rsvp_count"],
            distance: @events["results"][i]["distance"] * 100,
            date: time_zone(@events["results"][i]["time"])
          })
        end
        
        i = i + 1
      end
      return meetups_arr
    end

    def time_zone(date)
      Time.zone = 'Eastern Time (US & Canada)'
      Time.zone.at(date / 1000).strftime("%B %e, %Y at %I:%M %p")
    end

end
