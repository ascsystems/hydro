module OrdersHelper

    def us_states
        StateTaxRate.all.map{|s|[s.state_acronym,s.state_acronym]}
    end

    def total_price(products)
        products.sum(&:product_price)
    end

    def total_tax(total,state)
      state_rate = StateTaxRate.find_by_state_acronym(state).try(:tax_rate)
      tax = total.to_f * (state_rate.to_f/100)
      tax.round(2)
    end

    def total_amount(total, tax)
      total + tax
    end
end