class EmailSubscriptionsController < ApplicationController

  def new
    
  end
  
  def subscribe

    @email_subscription = EmailSubscription.new(params[:email_subscription])

    gb = Gibbon::API.new("b92f5602b14f6f3c601455e01b8cd94d-us1")
    gb.throws_exceptions = false
    gb.lists.subscribe({id: "f142997235", email: {email: params[:email_subscription]['email_address']}, merge_vars: {FNAME: "None", LNAME: ""}, double_optin: false})

    respond_to do |format|
      @email_subscription.save
      format.html { render action: "subscribe" }
    end

  end
  
  def unsubscribe
    email_subscription = EmailSubscription.find_by_email_address(params[:the_email_address])
    
    email_subscription.destroy if email_subscription
    @unsubscribe_message = "No such address"
    
    # renders unsubscribe.html.erb
  end
  
end