ActiveAdmin.register Subscription do
  menu parent: "Plan"

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

  filter :plan, as: :searchable_select
  filter :start_date
  filter :end_date
  filter :trial_date
  filter :created_at


end