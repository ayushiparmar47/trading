class AddPaymentIdSubscribe < ActiveRecord::Migration[5.2]
  def change
  	add_column :subscriptions, :stripe_payment_id, :string
  end
end
