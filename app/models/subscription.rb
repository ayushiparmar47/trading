class Subscription < ApplicationRecord
	belongs_to :plan
	belongs_to :user
  
  #attr_accessor :stripe_card_token

  before_save :subscription_details
  after_create :pay_amount
  after_create :info_mail

	# def save_with_payment(user, plan_id, stripe_card_token)
 #  	plan = Plan.find(plan_id)
 #    customer = Stripe::Customer.create(email: user.email, name: user&.first_name, plan: plan.stripe_plan_id, card: stripe_card_token)	    
 #    price = Stripe::Price.create({unit_amount: plan.amount.to_i, currency: plan.currency, recurring: {interval: plan.interval}, product: plan.stripe_product_id})
 #    subscription = Stripe::Subscription.create({ customer: customer.id, items: [{price: price.id}]})
 #    self.stripe_customer_id = customer.id
 #    self.stripe_subscription_id = subscription.id
 #    self.start_date = Time.now
 #    self.end_date = get_end_date(plan)
 #    self.trial_date = get_trial_date(plan)
	# end

  def subscription_details
    self.start_date = Time.now
    self.end_date = get_end_date(self.plan)
    self.trial_date = get_trial_date(self.plan)
  end

  def pay_amount
    user = User.find(self.user_id)
    referrer_id = user.referrer_id
    plan = Plan.find(self.plan_id)
    if referal_bonus.present?
      refer_amount = get_amount(plan.amount, referal_bonus.refer_discount)
      subscriber_amount = get_amount(plan.amount, referal_bonus.subscriber_discount)
      unless check_amount(referrer_id, user).present?
        if referrer_id.present?
          PayAmount.create(user_id: referrer_id, referrer_id: user.id, amount: refer_amount, payment_type: "referrer", status: 0)
          PayAmount.create(user_id: user.id, referrer_id: referrer_id, amount: subscriber_amount, payment_type: "referrer", status: 0)
        end
      end
    end  
  end

  def get_amount(amount, discount)
    amount*(discount.to_f/100)&.round(2)
  end

  def check_amount(referrer_id, user)
    PayAmount.where(user_id: referrer_id, referrer_id: user.id)
  end

  def referal_bonus
    ReferralBonus.find_by(active: true)
  end

  def get_end_date(plan)
    Time.now + plan&.interval_count&.send(plan.interval)
  end

  def get_trial_date(plan)
    Time.now + plan&.trial_day&.day
  end

  def info_mail
    Delayed::Job.enqueue(SubscriptionJob.new(self), 0, self&.end_date&.getutc - 3.day)
    Delayed::Job.enqueue(SubscriptionExpireJob.new(self), 0, self&.end_date&.getutc)
  end

end
