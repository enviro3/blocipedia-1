require 'stripe'
class ChargesController < ApplicationController

  def create
    @user = current_user
    @amount = 15_00
    
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Upgrade to Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
    
    @user.update_attributes(role: 'premium')
  
    flash[:notice] = "Thanks for the payment, #{current_user.email}! You can now create and edit private wikis."
    redirect_to user_path(current_user) # or wherever
  
    # Stripe will send back CardErrors, with friendly messages when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.name}",
      amount: 15_00
    }
  end
  
  def cancel
    subscription = Stripe::Subscription.retrieve("sub_8Xw6Ak8Gc4EvJx")
    subscription.delete(at_period_end: true)
    
    current_user.update_attribute(:role, 'standard')
    current_user.wikis.where(private: true).update_all(private: false)
    
    
    flash[:notice] = "You are now a Standard Member."
    redirect_to wikis_path
  end

  private

  def upgrade_user_role
    @user.role = 'premium'
  end

end
