class AdminRestaurantSerializer < ActiveModel::Serializer
    attributes :name, :address, :phone, :email, :balance

    has_many :coupons

    class CouponSerializer < ActiveModel::Serializer
        attributes :description, :quantity, :remaining, :expired, :tags, :expiration_time

        def tags
            object.tags.map(&:cuisine)
        end
    end
end