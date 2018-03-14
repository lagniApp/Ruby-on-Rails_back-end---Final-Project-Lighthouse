class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :update, :destroy]


  console
  # GET /coupons
  def index
    # @coupons = Restaurant.coupons
    @coupons = Coupon.all
    # @coupons.each do |coupon|
    #   coupon[:restaurant] = Restaurant.find_by_id(coupon.restaurant_id)
    #   # coupon.merge( {:restaurant => Restaurant.find_by_id(coupon.restaurant_id) } )
    # end
    render json: @coupons
  end

  # GET /coupons/1
  def show
    render json: @coupon
  end

  # POST /coupons
  def create
    parsed = JSON.parse(request.raw_post)
    puts parsed
    coupon_params = {
      restaurant_id: parsed['restaurantId'],
      description: parsed['description'],
      quantity: parsed['quantity'],
      created_at: Time.now,
      updated_at: Time.now,
      
      # tags: parsed['tags']
    }

    puts coupon_params

    @coupon = Coupon.new(coupon_params)

    if @coupon.save!
      render json: @coupon, status: :created, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupons/1
  def update
    if @coupon.update(coupon_params)
      render json: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_params
      params.require(:coupon).permit(:description, :quantity, :restaurant_id)
    end
end
