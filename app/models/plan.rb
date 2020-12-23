class Plan < ApplicationRecord

	enum interval: { day: 0, week: 1, month: 2, year: 3 }

	# has_many :plan_subscriptions
  # has_many :users, through: :plan_subscriptions, dependent: :destroy
 	has_many :subscriptions
  has_many :users, through: :subscriptions, dependent: :destroy

end
