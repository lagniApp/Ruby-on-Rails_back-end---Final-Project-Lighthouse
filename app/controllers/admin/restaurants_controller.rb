class Admin::RestaurantsController < ApplicationController
  http_basic_authenticate_with name: ENV['USERADMIN'], password: ENV['PASSWORD']

  def index
    @restaurants = Restaurant.order(id: :desc).all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to [:admin, :restaurants], notice: 'restaurant created!'
    else
      render :new
    end
  end

  def destroy
    @restaurant = Restaurant.find params[:id]
    @restaurant.destroy
    redirect_to [:admin, :restaurants], notice: 'restaurant deleted!'
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
        :balance, 
        :longitude, 
        :latitude
    )
  end

end
