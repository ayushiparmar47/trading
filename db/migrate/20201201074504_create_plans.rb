class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
    	t.integer :plan_type
    	t.integer :duration
    	t.integer :duration_type
    	t.float :amount
      t.timestamps
    end
  end
end
