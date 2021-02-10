class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
    	t.float :amount
      t.references :user, index: true
      t.string :stripe_charge_id
      t.integer :status
      t.string :payment_source
      t.timestamps
    end
  end
end
