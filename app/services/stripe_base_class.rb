
class StripeBaseClass < BaseService  
  
  def initialize(stripe_token, user, type, plan_id)
    @stripe_token = stripe_token
    @user = user
    @type = type
    @plan_id = plan_id
   end

  def payment_intent
    payment_types = []
    payment_types << @type
    plan = Plan.find(@plan_id)
    Stripe::PaymentIntent.create({
      amount: plan.amount&.to_i,
      currency: plan.currency,
      payment_method_types: payment_types,
      description: "#{@user.email} payment intent services",
    })
  end

  def charge
    plan = Plan.find(@plan_id)
    Stripe::Charge.create({
      amount: (plan.amount&.to_i * 100),
      currency: plan.currency,
      source: @stripe_token,
      description: "#{@user.email} Charge",
    })
  end

  def create_subscription
    plan = Plan.find(@plan_id)
    @user.subscription_data
  end

  def price
    plan = Plan.find(@plan_id)
    Stripe::Price.create(
      {
        unit_amount: plan.amount.to_i,
        currency: plan.currency,
        recurring: {
          interval: plan.interval
        },
        product: plan.stripe_product_id
      }
    )
  end

  def refund
    
  end

end
