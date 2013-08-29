class AddCostToShippings < ActiveRecord::Migration
  def change
    
    # staging server db was in a bad state, so it needed this - create table if it doesn't exist
    unless ActiveRecord::Base.connection.tables.include?(:shippings)
    
      create_table :shippings do |t|
        t.string :display_text
  
        t.timestamps
      end
    end
    
    
    
    add_column :shippings, :cost, :float
  end
end
