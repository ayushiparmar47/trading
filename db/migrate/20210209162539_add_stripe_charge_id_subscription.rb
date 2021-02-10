class AddStripeChargeIdSubscription < ActiveRecord::Migration[5.2]
  def change
  	add_column :subscriptions, :stripe_charge_id, :string
  	remove_column :subscriptions, :stripe_payment_id
  end
end
