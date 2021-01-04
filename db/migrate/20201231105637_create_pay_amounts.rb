class CreatePayAmounts < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_amounts do |t|
    	t.references :user, foreign_key: true
    	t.integer :referrer_id
    	t.float :amount
    	t.string :payment_type
    	t.integer :status
    	t.boolean :payed, :default => false
      t.timestamps
    end
  end
end
