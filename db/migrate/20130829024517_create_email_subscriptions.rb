class CreateEmailSubscriptions < ActiveRecord::Migration
  def change
    
    create_table :email_subscriptions do |t|
      t.integer :user_id  # optional association
      t.string :email_address, :limit => 50
      
      t.timestamps
    end
    
    add_index :email_subscriptions, :user_id
    
  end
end
