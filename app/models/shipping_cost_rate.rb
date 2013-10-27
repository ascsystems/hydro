class ShippingCostRate < ActiveRecord::Base
  attr_accessible :country, :state, :zip, :total_cost_tier, :shipping_cost
  
  DEFAULT_SHIPPING_COST_WILDCARD = '*'
 
  #---------------------------------------------------------------------------
  # Get the list of shipping cost per order_cost tier, for a particular State (or the global '*' entries)
  def self.find_shipping_costs_by_state(the_state, order_cost)
    where(:state => the_state).where('? <= total_cost_tier', order_cost).order('total_cost_tier DESC')
  end
  #---------------------------------------------------------------------------
  
  #---------------------------------------------------------------------------
  # Get the best shipping rate based on the order_cost
  def self.find_best_shipping_cost(the_state, order_cost)
    best_cost = find_shipping_costs_by_state(the_state, order_cost).first
    
    # state-specific shipping cost not found, so find the wildcard shipping cost entry for thier order_cost tier
    unless best_cost
      best_cost = find_shipping_costs_by_state(DEFAULT_SHIPPING_COST_WILDCARD, order_cost).first
    end
    best_cost
  end
  #---------------------------------------------------------------------------
  
end