class Coupon < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :tags

  def restaurant 
    Restaurant.find_by_id(restaurant_id)
  end

  # def tags
  #   Coupon.coupons_tag.Tag.all
  #   @coupon.tags << @tag

    # SELECT * FROM coupons_tags WHERE id = Coupon.id

    # tags = []
    # Coupons_tags.find(:conditions => {"coupon_id" => id})

    # Tag.find(:conditions => {"coupon_id" => id})
    # if tag
    #   return tag
    # else
    #   return []
    # end
  # end


  def as_json(options={})
    {
      id: id,
      description: description,
      quantity: quantity,
      remaining: remaining,
      restaurant_id: restaurant_id,
      created_at: created_at,
      updated_at: updated_at,
      restaurant: restaurant,
      # tags: tags
    }
  end
end
