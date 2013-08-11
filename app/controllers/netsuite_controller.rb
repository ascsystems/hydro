class NetsuiteController < ApplicationController
  
  def items
    items = NetSuite::Records::InventoryItem.get()
    render text: items.inspect
  end

  def item
    @item = NetSuite::Records::InventoryItem.get(params[:id])
  end

  def orders
    orders = NetSuite::Records::SalesOrder.get()
    render text: orders.inspect
  end

  def order
    @order = NetSuite::Records::SalesOrder.get(params[:id])
  end

  def addOrder
    #order = NetSuite::Records::Customer.new(company_name: 'Test Company', first_name: 'David', last_name: 'Seemiller', email: 'david@ascsystems.com', phone: '703-501-6812', password: 'password', unsubscribe: true);
    order = NetSuite::Records::Contact.new(first_name: 'Ringo', last_name: 'Starr', email: 'david@ascsystems.com', phone: '703-501-6812')
    order.add
    #orders = NetSuite::Records::SalesOrder.get()
    render text: order.inspect
  end

end
