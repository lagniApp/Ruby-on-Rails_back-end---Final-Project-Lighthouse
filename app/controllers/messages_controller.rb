class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # # GET /messages
  # def index
  #   @messages = Message.all

  #   render json: @messages
  # end

  # # GET /messages/1
  # def show
  #   render json: @message
  # end

  # POST /messages
  def create
    parsed = JSON.parse(request.raw_post)
    puts parsed
    # byebug
    puts parsed["messageData"]["restName"]
    params = {

      restName: parsed["messageData"]["restName"],
      couponInfo: parsed["messageData"]["couponInfo"],
      address: parsed["messageData"]["address"],
      phone: parsed["messageData"]["phone"],
      id: parsed["messageData"]["id"]
    }
      puts "#{params[:id]} params[:id]"

    # subtract coupon's ramaining column by 1
      a = Coupon.find(params[:id])
      puts a
      puts a.remaining
      update_db(params[:id])
      puts a.remaining
      phone = params[:phone]

      message = "Here is your Coupon for #{params[:restName]} #{params[:couponInfo]} at #{params[:address]} Link localhost:3000/coupons/#{params[:id]}"
      TwilioTextMessenger.new(message, phone).call
    # if @message
    #   render json: @message, status: :created, location: @message
    # else
    #   render json: @message.errors, status: :unprocessable_entity

  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_message
  #     @message = Message.find(params[:id])
  #   end
    def update_db(coupon_id)
      coupon = Coupon.find(coupon_id)
      coupon.remaining -= 1
      coupon.save
    end

  #   # Only allow a trusted parameter "white list" through.
  #   def message_params
  #     params.require(:message).permit(:sms_message, :string, :user_phone, :string)
  #   end
end
