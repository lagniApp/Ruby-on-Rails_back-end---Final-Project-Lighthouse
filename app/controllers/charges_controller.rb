class ChargesController < ActionController::Base
    def new
        render :new
    end
    
    def create
      # Amount in cents
      # always set on server side
      @amount = 500
    
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
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to :root
    end
end