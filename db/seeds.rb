# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Data for ShippingCostRate definitions:
ShippingCostRate.create(country: 'USA', state: '*', zip: '', total_cost_tier: 3.99, shipping_cost: 1.99
ShippingCostRate.create(country: 'USA', state: '*', zip: '', total_cost_tier: 11.99, shipping_cost: 7.99)
ShippingCostRate.create(country: 'USA', state: '*', zip: '', total_cost_tier: 74.99, shipping_cost: 0.0)

ShippingCostRate.create(country: 'USA', state: 'AK', zip: '', total_cost_tier: 3.99, shipping_cost: 3.99
ShippingCostRate.create(country: 'USA', state: 'AK', zip: '', total_cost_tier: 11.99, shipping_cost: 10.99)
ShippingCostRate.create(country: 'USA', state: 'AK', zip: '', total_cost_tier: 74.99, shipping_cost: 10.99)

