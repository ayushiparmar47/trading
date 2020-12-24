class Subscription < ApplicationRecord
	belongs_to :plan
	belongs_to :user
  
  attr_accessor :stripe_card_token

	def save_with_payment(user, plan_id, stripe_card_token)
  	plan = Plan.find(plan_id)
    customer = Stripe::Customer.create(email: user.email, name: user&.first_name, plan: plan.stripe_plan_id, card: stripe_card_token)	    
    price = Stripe::Price.create({unit_amount: plan.amount.to_i, currency: plan.currency, recurring: {interval: plan.interval}, product: plan.stripe_product_id})
    subscription = Stripe::Subscription.create({ customer: customer.id, items: [{price: price.id}]})
    self.stripe_customer_id = customer.id
    self.stripe_subscription_id = subscription.id
	end
end
