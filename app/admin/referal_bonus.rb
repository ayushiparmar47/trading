ActiveAdmin.register ReferralBonus, as: 'Plan Offers' do
  menu parent: "Plan"
  permit_params :refer_discount, :subscriber_discount, :start_date, :end_date, :active

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
    actions
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
