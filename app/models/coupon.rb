class Coupon < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :tags

  # console
  def restaurant 
    Restaurant.find_by_id(restaurant_id)
  end

  def tags
    @coupon = Coupon.all

    # books.includes(:user).where('users.name="Guava"').references(:user)

    # @coupons.each do |coupon|
    #   coupon.coupon_tags.includes(tag).each do |tag| 
    #     puts tag
    #   end
      # coupon.merge( {:restaurant => Restaurant.find_by_id(coupon.restaurant_id) } )
    # end
    # coupon1 = Coupon.find(2)
    # coupons_tags.find(:conditions => {"coupon_id" => id})
    # coupon.coupons_tags. 
  #   Coupon.coupons_tag.Tag.all
    # Coupon.tags << @tag
    # meal.meal_ingredients.includes(:ingredient).each do |meal_ingredient|
  #   meal_ingredient.amount
  #   puts meal_ingredient.ingredient.name
  # end

    # Tag.coupons_tags.find_by_id(id)
    # SELECT * FROM coupons_tags WHERE id = Coupon.id

    # tags = []
    # Coupons_tags.find(:conditions => {"coupon_id" => id})

    # Tag.find(:conditions => {"coupon_id" => id})
    # if tag
    #   return tag
    # else
    #   return []
    # end
  end


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
      tags: tags
    }
  end
end
