class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :product_id
      t.string :name
      t.integer :rating
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
