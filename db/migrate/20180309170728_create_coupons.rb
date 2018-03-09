class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.text :description
      t.integer :quantity
      t.datetime :remaining
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
