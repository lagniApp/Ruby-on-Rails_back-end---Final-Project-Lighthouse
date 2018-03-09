class Restaurant < ApplicationRecord
  has_many :coupons

  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :phone, presence: true
  validates :address, presence: true

end
