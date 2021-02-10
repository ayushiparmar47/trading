
class StripeBaseClass < BaseService  
  
  def initialize(params, user)
    @stripe_token = params[:subscription][:stripeToken]
    @params = params
    @amount = params[:subscription][:amount].to_i
    @user = user
    @type = params[:subscription][:type]
    @plan_id = params[:subscription][:plan_id]
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
      amount: @amount,
      #currency: "inr",
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

end
