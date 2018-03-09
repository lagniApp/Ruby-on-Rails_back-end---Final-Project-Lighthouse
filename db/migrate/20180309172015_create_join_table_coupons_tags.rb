class CreateJoinTableCouponsTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :coupons, :tags
  end
end
