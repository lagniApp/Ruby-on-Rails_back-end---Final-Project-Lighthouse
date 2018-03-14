class Tag < ApplicationRecord
  has_many :coupons_tags
  has_many :coupons, through: :coupons_tags
end