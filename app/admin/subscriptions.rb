ActiveAdmin.register Subscription do
  menu parent: "Plan"

  member_action :unsubscription, method: :delete do
    user = resource.user
    if resource.destroy
      user.update(subscribed: false)
      flash[:notice] = ('Plan unsubscribe to successesfull.')
    else
      flash[:error] = resource&.errors&.full_messages&.to_sentence
    end
    redirect_to admin_subscriptions_path
  end

	index do
    selectable_column
    id_column
    column :image do |subscription|
      if subscription&.user&.image&.present?
        image_path = "#{subscription&.user&.image_url}"
      else
        image_path = ActionController::Base.helpers.image_url("blanck_user.png")
      end
      image_tag image_path  
    end
    column :user do |subscription|
      subscription.user.first_name
    end
    column :plan
    column "Subscribe At", :start_date
    column "Expire At", :end_date
    column "Upto Trial", :trial_date
    actions defaults: true do |subscription|
      link_to "Unsubscribe", unsubscription_admin_subscription_path(subscription.id), method: :delete, data: {confirm: "Are you sure to unsubscribe?"}
    end 
  end

  filter :plan, as: :searchable_select
  filter :start_date, label: "Subscribe At"
  filter :end_date, label: "Expire At"
  filter :trial_date, label: "Upto Trial"
  
  show do
    attributes_table do
      row :image do |subscription|
        if subscription&.user&.image&.present?
          image_path = "#{subscription&.user&.image_url}"
        else
          image_path = ActionController::Base.helpers.image_url("blanck_user.png")
        end
        image_tag image_path  
      end
      row :user do |subscription|
        subscription.user.first_name
      end
      row :plan
      row "Subscribe At", :start_date do |subscription|
        subscription&.start_date
      end
      row "Expire At", :end_date do |subscription|
        subscription&.end_date
      end
      row "Upto Trial", :trial_date do |subscription|
        subscription&.trial_date
      end
    end
  end

end