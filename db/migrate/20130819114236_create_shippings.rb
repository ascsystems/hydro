class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :display_text

      t.timestamps
    end
  end
end
