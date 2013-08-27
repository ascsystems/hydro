class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :name
      t.string :email
      t.string :serial_number
      t.string :place_of_purchase
      t.string :flask_purchased
      t.integer :charity_id
      t.integer :newsletter
      t.text :comments

      t.timestamps
    end
  end
end
