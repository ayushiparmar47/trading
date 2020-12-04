ActiveAdmin.register Plan do
  permit_params :plan_type, :duration, :duration_type, :amount
  
  index do
    selectable_column
    id_column
    column :plan_type
    column :duration do |plan|
      "#{plan.duration} #{plan.duration_type}"
    end
    column :amount do |plan|
      "$ #{plan.amount}"
    end
    actions
  end

  filter :plan_type
  filter :duration
  filter :duration_type
  filter :amount

  form do |f|
    f.inputs do
      f.input :plan_type, as: :searchable_select
      f.input :duration, input_html: {:style => 'width:28.5%'}
      f.input :duration_type, as: :searchable_select
      f.input :amount, input_html: {:style => 'width:28.5%'}  
    end
    f.actions
  end

  show do
    attributes_table do
      row :plan_type
      row :duration do |plan|
        "#{plan.duration} #{plan.duration_type}"
      end
      row :amount do |plan|
        "$ #{plan.amount}"
      end
    end
  end
  
end
