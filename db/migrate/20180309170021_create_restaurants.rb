class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :address
      t.float :balance
      t.json :couponsJSON
      t.json :meetups
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
