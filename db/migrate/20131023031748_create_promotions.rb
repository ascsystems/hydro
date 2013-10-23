class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :promo_code
      t.date :start_date
      t.date :end_date
      t.decimal :amount
      t.string :type

      t.timestamps
    end
  end
end
