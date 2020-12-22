class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
    	t.integer :user_id
    	t.integer :plan_id
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.timestamps
    end
  end
end
