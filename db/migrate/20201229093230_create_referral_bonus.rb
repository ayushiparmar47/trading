class CreateReferralBonus < ActiveRecord::Migration[5.2]
  def change
    create_table :referral_bonus do |t|
    	t.integer :refer_discount
    	t.integer :subscriber_discount
    	t.datetime :start_date
    	t.datetime :end_date
    	t.boolean :active, :default => false
      t.timestamps
    end
  end
end
