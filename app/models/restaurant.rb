class Restaurant < ApplicationRecord
  has_many :coupons

  validates :name, presence: true
  validates :username, presence: true
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :password, presence: true
  validates :phone, format: { with: \A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z }
  validates :address, presence: true

end
