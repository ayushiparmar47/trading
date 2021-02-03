class CreateDiscountCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_codes do |t|
    	t.string :codes
    	t.integer :discount
    	t.references :plan, index: true
    	t.integer :user_id, array:true, default: []
    	t.datetime :start_date
    	t.datetime :end_date
    	t.boolean :active, :default => false
      t.timestamps
    end
  end
end
