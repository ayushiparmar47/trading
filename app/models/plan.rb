class Plan < ApplicationRecord
	
	enum plan_type: { free: 0, premimum: 1 }
	enum duration_type: { month: 0, year: 1 }

	has_many :plan_subscriptions
  has_many :users, through: :plan_subscriptions, dependent: :destroy

end
