class CreateShippingCostRates < ActiveRecord::Migration
  def up
    create_table :shipping_cost_rates do |t|
      t.string :country, :limit => 25
      t.string :state, :limit => 25
      t.string :zip, :limit => 50
      t.decimal :total_cost_tier, :precision => 8, :scale => 2
      t.decimal :shipping_cost, :precision => 8, :scale => 2
      
      t.timestamps
    end
    
    #TODO: add other combined indexes in future migrations
    add_index :shipping_cost_rates, :state
    
  end

end
