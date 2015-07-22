class ChargesController < ApplicationController

def create
 
  # if current_user.role != 'premium'
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   charge = Stripe::Charge.create(
     :customer => customer.id, # Note -- this is NOT the user_id in your app
     :amount => 1500,
     :description => "Blocipedia Premium Membership - #{current_user.email}",
     :currency => 'usd'
   )
 
   flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
   current_user.role = "premium"
   current_user.save
   redirect_to new_wiki_path
 
 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end

def new
   @stripe_btn_data = {
     :key => "#{ Rails.configuration.stripe[:publishable_key] }",
     :description => "Blocipedia Premium Membership - #{current_user.name}",
     :amount => 1500
   }
 end

end
