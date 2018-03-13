class Restaurant < ApplicationRecord
  has_many :coupons

  has_secure_password

  validates :name, presence: true
  validates :username, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :password, presence: true,
          :presence => { :on => :create },
          :length   => { :minimum => 6, :allow_nil => true }
  validates :email, :presence => true,
          :format => { :with => email_regex },
          :uniqueness => { :case_sensitive => false }




  def self.authenticate_with_credentials(email, password)
    restaurant = Restaurant.find_by_email(email.strip.downcase)
    # If the restaurant exists AND the password entered is correct.
    if restaurant && restaurant.authenticate(password)
      puts 'Im here'
      return restaurant
    else
      nil
    end
  end


end
