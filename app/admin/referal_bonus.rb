ActiveAdmin.register ReferralBonus, as: 'Plan Offers' do
  menu parent: "Plan"
  permit_params :refer_discount, :subscriber_discount, :start_date, :end_date, :active
  actions :all, :except => [:destroy]

  member_action :delete, method: :delete do
    resource.destroy
    flash[:notice] = ('Plan Offer destroyed')
    redirect_to admin_plan_offers_path
  end

  index do
    selectable_column
    id_column
    column :refer_discount do |referral_bonus|
      "#{referral_bonus.refer_discount} %"
    end
    column :subscriber_discount do |referral_bonus|
      "#{referral_bonus.subscriber_discount} %"
    end
    column :start_date
    column :end_date
    column :active
    column :created_at
    actions defaults: true do |referral_bonus|
      unless referral_bonus.active?
        link_to "Delete", delete_admin_plan_offer_path(referral_bonus.id), method: :delete, data: {confirm: "Are you sure you want to delete this?"}
      end
    end
  end

  show do
    attributes_table do
      row :refer_discount do |referral_bonus|
        "#{referral_bonus.refer_discount} %"
      end
      row :subscriber_discount do |referral_bonus|
        "#{referral_bonus.subscriber_discount} %"
      end
      row :start_date
      row :end_date
      row :active
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :refer_discount
      f.input :subscriber_discount
      f.input :start_date, as: :date_time_picker, datepicker_options: { min_date: Time.now}
      f.input :end_date, as: :date_time_picker, datepicker_options: { min_date: Time.now}
      f.input :active, as: :boolean
    end
    f.actions
  end

end
