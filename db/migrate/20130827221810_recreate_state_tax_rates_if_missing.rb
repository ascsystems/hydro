class RecreateStateTaxRatesIfMissing < ActiveRecord::Migration
  def change
    # fixup for missing table on server (migrations somehow go botched)
    unless ActiveRecord::Base.connection.tables.include?(:state_tax_rates)
    
      create_table :state_tax_rates do |t|
        t.integer :tax_rate
        t.string :state_acronym
  
        t.timestamps
      end
    end
  end

end
