class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.integer :featured

      t.timestamps
    end
  end
end
