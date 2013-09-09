module OrdersHelper

    def us_states
      StateTaxRate.all.map{|s|[s.state_acronym,s.state_acronym]}
    end

    def total_price(products)
      products.sum(&:product_price)
    end

    #FIXME: doesn't look like all of these are being called in the code (but they should be?)
    def total_tax(total,state)
      state_rate = StateTaxRate.find_by_state_acronym(state).try(:tax_rate)
      tax = total.to_f * (state_rate.to_f/100)
      tax.round(2)
    end

    #def total_amount(total, tax)
    #  total + tax
    #end

    # Might be used in the future
    #def total_amount_with_tax(the_total_price,state)
    #  tax = total_tax( the_total_price, state )
    #  amount = the_total_price + tax
    #end
    
    #-------------------------------------------------------------------------
    def total_including_tax_and_shipping(the_order, products)
      total_before_tax = total_price(products)
      the_tax = total_tax(total_before_tax, the_order.state)
      the_shipping_charge = computed_shipping_charge(the_order, total_before_tax)
      
      total_before_tax + the_tax + the_shipping_charge
    end
    #-------------------------------------------------------------------------
    
    #-------------------------------------------------------------------------
    # This is used to display all shipping options, with calculated costs
    # (so we DON'T call the_order.shipping within the method, it's passed in)
    def shipping_method_pretty_text(order, the_shipping_option)
      #FIXME: correct logic once FedEx is integrated
      if the_shipping_option.cost == 0 # standard shipping
        the_shipping_charge = computed_shipping_charge(the_order, total_price(current_cart.line_items), the_shipping_option)
        
        "#{the_shipping_option.display_text} - #{number_to_currency(the_shipping_charge)}"
      else
        # FIXME: FedEx lookup here
        "#{the_shipping_option.display_text} - #{number_to_currency(the_shipping_option.cost)}"
      end
    end
    #-------------------------------------------------------------------------
    
    #-------------------------------------------------------------------------
    # Get the shipping cost for this order cost tier, for this state,
    # then add on special shipping cost (no extra cost for standard shipping)
    def computed_shipping_charge(the_order, the_total_before_tax, the_shipping = nil)
      
      # if a Shipping object is passed in to this method, we use it
      # (for cases when shipping has not bee selected against the order yet)
      the_shipping_cost = the_shipping ? the_shipping.cost : the_order.shipping.cost
      
      # if FedEx options are given, we look them up differently
      
      #FIXME: correct logic once FedEx is integrated
      if the_shipping_cost == 0 # standard shipping
        ShippingCostRate.find_best_shipping_cost(the_order.state, the_total_before_tax).shipping_cost
      else
        # FIXME: FedEx lookup here
        the_shipping_cost
      end
    end
    #-------------------------------------------------------------------------
    
    # NOTE: this was the old method
    #def shipping_charge_OLD(the_order)
    #  shipping_cost = the_order.shipping.cost
    #  shipping_cost.to_i == 0 ? "Free" : "$#{number_with_precision(shipping_cost, :precision => 2)}"
    #end
    
end