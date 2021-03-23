class Plan < ApplicationRecord

	enum interval: { day: 0, week: 1, month: 2, year: 3 }
	
 	has_many :subscriptions
  has_many :users, through: :subscriptions, dependent: :destroy
  has_many :trade_plans, dependent: :destroy
  has_many :today_trades, through: :trade_plans
  #validates :name, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :trial_day, presence: true
  validates :amount, presence: true
  validates :interval, presence: true
  validates :interval_count, presence: true
  
  before_create :stripe_object

  def fee
  	"#{self.amount} / #{self.interval_count} #{self.interval}"
  end

  def stripe_object
  	stripe_product = Stripe::Product.create({name: self.name, type: 'service'})
    stripe_plan = Stripe::Plan.create({
      amount: self.amount&.to_i,
      currency: self.currency,
      interval: self.interval,
      product: stripe_product.id,
      interval_count: self.interval_count,
      nickname: self.name,
    })
 		self.stripe_plan_id = stripe_plan.id
    self.stripe_product_id = stripe_product.id   
  end

end
