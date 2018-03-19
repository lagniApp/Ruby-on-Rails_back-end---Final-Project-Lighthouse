class ChargesController < ActionController::Base
    def new
    end
    
    def create
      # Amount in cents
      # always set on server side
      puts params["restaurant_id"]
      @amount = (params["reload"].to_i) * 100
      puts @amount
    
    #   customer = Stripe::Customer.create(
    #     # :email => params[:stripeEmail],
    #     :source  => params[:stripeToken]
    #   )
    # Token is created using Checkout or Elements!
    # Get the payment token ID submitted by the form:
    token = params[:stripeToken]

      charge = Stripe::Charge.create(
        :amount      => @amount,
        :description => 'Lagni App reload',
        :currency    => 'cad',
        :source  => token
      )
   if charge.status == "succeeded"
    puts "YAY"
    add_charge(5, 100)
   else 
    puts "NOOO"
   end
    # puts charge_response
    render json: charge


    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to :root
    end


  private

  def add_charge(id, amount)
    # restaurant.balance += amount
    puts "add_charge"
    puts id
  end


end
