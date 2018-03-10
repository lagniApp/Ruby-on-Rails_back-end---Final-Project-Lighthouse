class SessionsController < ApplicationController
  
  def create
    restaurant = Restaurant.find_by_email(params[:email])
    # If the restaurant exists AND the password entered is correct.
    if restaurant && restaurant.authenticate(params[:password])
      # Save the restaurant id inside the browser cookie. This is how we keep the restaurant 
      # logged in when they navigate around our website.
      session[:restaurant_id] = restaurant.id
      redirect_to [:root], notice: 'Login Successful'
    else
    # If restaurant's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:restaurant_id] = nil
    redirect_to [:root], notice: 'Logged Out !'
  end

end