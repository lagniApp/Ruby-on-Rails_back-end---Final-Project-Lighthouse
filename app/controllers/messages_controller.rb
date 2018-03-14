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
    puts parsed["messageData"]["restName"]
    params = {
      
      restName: parsed["messageData"]["restName"],
      couponInfo: parsed["messageData"]["couponInfo"],
      address: parsed["messageData"]["address"],
      phone: parsed["messageData"]["phone"],
    }
    puts "#{params} PARAMS"

    # @message = Message.new(params)
    # respond_to do |format|
      message = "Restaurant name go here"
      TwilioTextMessenger.new(message).call
    # if @message
    #   render json: @message, status: :created, location: @message
    # else
    #   render json: @message.errors, status: :unprocessable_entity
  
  end

 

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_message
  #     @message = Message.find(params[:id])
  #   end

  #   # Only allow a trusted parameter "white list" through.
  #   def message_params
  #     params.require(:message).permit(:sms_message, :string, :user_phone, :string)
  #   end
end
