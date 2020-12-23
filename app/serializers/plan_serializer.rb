class PlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :currency, :interval_count, :interval, :stripe_plan_id, :stripe_product_id
end
