class CreateStateTaxRates < ActiveRecord::Migration
  def change
    
    # order go botched up on the server, so I need to make this conditional
    #unless ActiveRecord::Base.connection.tables.include?(:state_tax_rates)
    
      create_table :state_tax_rates do |t|
        t.integer :tax_rate
        t.string :state_acronym
  
        t.timestamps
      end
    #end
    
  end
end
