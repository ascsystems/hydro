class HydroMailer < ActionMailer::Base
  
  def purchase_notification_email(order)
    #@user = order.customer
    @order = order
    mail(to: "david@aztec-apps.com", from: "notifier@hydroflask.com", subject: "Hydro Flask Order Notification - Order ID: #{order.invoice_number}")
  end
  
end
