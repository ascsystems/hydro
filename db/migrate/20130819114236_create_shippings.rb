class CreateShippings < ActiveRecord::Migration
  def change
    
    # order go botched up on the server, so I need to make this conditional
    #unless ActiveRecord::Base.connection.tables.include?(:shippings)
    
      create_table :shippings do |t|
        t.string :display_text
  
        t.timestamps
      end
    #end
    
  end
end
