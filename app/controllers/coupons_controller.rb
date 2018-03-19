class CouponsController < ApplicationController
  # before_action :set_coupon, only: [:show, :update, :destroy]

  # GET /coupons
  def index
    # @coupons = Restaurant.coupons
    @coupons = Coupon.where(expired: false).where("expiration_time > ?", DateTime.now).where("remaining > 0")
    # @coupons.each do |coupon|
    #   coupon[:restaurant] = Restaurant.find_by_id(coupon.restaurant_id)
    #   # coupon.merge( {:restaurant => Restaurant.find_by_id(coupon.restaurant_id) } )
    # end
    render json: @coupons

    # update all expired coupons to true
    Coupon.where(expired: false).where("expiration_time < ?", DateTime.now).update_all(expired: true)
    Coupon.where(expired: false).where("remaining <= 0").update_all(expired: true)
  end

  # GET /coupons/1
  def show
    set_coupons
    render json: @coupon
  end

  # POST /coupons
  def create
    parsed = JSON.parse(request.raw_post)
    @restaurant = Restaurant.find_by(id: parsed['restaurantId'])
    hours = (parsed['how_long'].to_i) * 60 * 60
    coupon_params = {
      restaurant_id: parsed['restaurantId'],
      description: parsed['description'],
      quantity: parsed['quantity'],
      remaining: parsed['quantity'],
      expiration_time: (Time.now + hours),
      created_at: Time.now,
      updated_at: Time.now
    }

    @coupon = @restaurant.coupons.new(coupon_params)

    get_tags(parsed)
      if @coupon.save!
          response = { message: "Coupon created" }
        else
          response = { message: "Not created, please check the fields" }
        end
      render json: response
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
    @coupon = set_coupons
    timer = (@coupon.created_at + 600)
    if (timer > Time.now)
      @coupon.destroy!
      response = { message: "Deleted" }
    else
      response = { message: "Not deleted, you exceded the time limite of 10 minutes to delete a coupon", error: "Not valid" }
    end
    render json: response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupons
      @coupon = Coupon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_params
      params.require(:coupon).permit(:restaurant_id, :description, :quantity, :remaining, :created_at)
    end

    def get_tags(parsed)
      @parsed_tags = []

      parsed['tags'].each do |keys, value|
        if value
          tagged = Tag.find_by(cuisine: keys)
          @parsed_tags.push({
            cuisine: keys,
            created_at: Time.now,
            updated_at: Time.now
          })
          # byebug
        @coupon.tags << tagged
        end
      end
    end
end
