class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.text :description
      t.integer :quantity
      t.integer :remaining
      t.boolean :expired
      t.datetime :expiration_time
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
