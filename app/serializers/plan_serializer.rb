class PlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :currency, :interval_count, :interval, :trial_day, :country, :stripe_plan_id, :stripe_product_id, :created_at
end
