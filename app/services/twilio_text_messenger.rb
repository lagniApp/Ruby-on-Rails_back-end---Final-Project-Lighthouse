class TwilioTextMessenger
    attr_reader :message
   
    def initialize(message, phone)
      @message = message
      @phone = phone 
      puts @phone 
    end
   puts @message
    def call
      client = Twilio::REST::Client.new
      client.messages.create({
        from: Rails.application.secrets.twilio_phone_number,
        to: @phone,
        body: message
      })
    end
  end