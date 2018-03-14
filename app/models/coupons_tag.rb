class CouponsTag < ApplicationRecord
    belongs_to :coupon
    belongs_to :tag
end