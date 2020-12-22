class CreatePlanSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_subscriptions do |t|
    	t.references :user, index: true
    	t.references :plan, index: true
    	t.datetime :start_date
    	t.datetime :end_date
    	t.string :status
      t.timestamps
    end
  end
end
