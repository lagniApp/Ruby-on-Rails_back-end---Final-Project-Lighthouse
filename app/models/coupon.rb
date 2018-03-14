class Coupon < ApplicationRecord
  belongs_to :restaurant
  has_many :coupons_tags
  has_many :tags, through: :coupons_tags


  def as_json(options={})
    {
      id: id,
      description: description,
      quantity: quantity,
      remaining: remaining,
      restaurant_id: restaurant_id,
      created_at: created_at,
      updated_at: updated_at,
      # restaurant: restaurant,
      tags: tags.to_a
    }
  end
end
