class AddTrialDay < ActiveRecord::Migration[5.2]
  def change
  	add_column :plans, :trial_day, :integer
  	add_column :subscriptions, :start_date, :datetime
  	add_column :subscriptions, :end_date, :datetime
  	add_column :subscriptions, :trial_date, :datetime
  end
end
