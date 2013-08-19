class CreateStateTaxRates < ActiveRecord::Migration
  def change
    create_table :state_tax_rates do |t|
      t.integer :tax_rate
      t.string :state_acronym

      t.timestamps
    end
  end
end
