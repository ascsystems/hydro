class EmailSubscriptionsController < ApplicationController

  def new
    
  end
  
  def subscribe
    @email_subscription = EmailSubscription.create!(params[:email_subscription])

    respond_to do |format|
      format.html # subscribe.html.erb
      format.js
    end
  end
  
  def unsubscribe
    email_subscription = EmailSubscription.find_by_email_address(params[:the_email_address])
    
    email_subscription.destroy if email_subscription
    @unsubscribe_message = "No such address"
    
    # renders unsubscribe.html.erb
  end
  
end