class AddColumnInPlan < ActiveRecord::Migration[5.2]
  def change
  	add_column :plans, :name, :string
  	add_column :plans, :currency, :string
  	add_column :plans, :interval, :integer
  	add_column :plans, :interval_count, :integer
  	add_column :plans, :stripe_plan_id, :string
    add_column :plans, :stripe_product_id, :string
  	remove_column :plans, :plan_type, :integer
  	remove_column :plans, :duration, :integer
  	remove_column :plans, :duration_type, :integer
  end
end