class Restaurant < ApplicationRecord
  has_many :coupons

  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  def authenticate_with_credentials(email, password)
    restaurant = Restaurant.find_by_email(email.strip.downcase)
    # If the restaurant exists AND the password entered is correct.
    if restaurant && restaurant.authenticate(password)
      return restaurant
    end
    nil
  end

end
