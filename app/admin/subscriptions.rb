ActiveAdmin.register Subscription do
    menu parent: "Plan"
	actions :all, :except => [:new, :edit, :destroy, :show]

	index do
    selectable_column
    id_column
    column :user do |subscription|
      subscription.user.first_name
    end
    column :plan
    column :start_date
    column :end_date
    column :trial_date
  end

end