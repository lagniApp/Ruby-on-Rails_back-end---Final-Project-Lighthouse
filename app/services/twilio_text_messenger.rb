class TwilioTextMessenger
    attr_reader :message
   
    def initialize(message)
      @message = message
    end
   puts @message
    def call
      client = Twilio::REST::Client.new
      client.messages.create({
        from: Rails.application.secrets.twilio_phone_number,
        to: '+16472296260',
        body: message
      })
    end
  end