ActiveAdmin.register TodayTrade do
	menu parent: "Trade"

  permit_params :company_id, :for_free_plan, :expected_rate

  index do
    selectable_column
    id_column
    column :company
    column :expected_rate
    column :for_free_plan
    column :created_at
    actions
  end

  filter :company, as: :searchable_select
  filter :expected_rate
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :company_id, as: :searchable_select, input_html: {:style => 'width:28.5%'}, :collection => Company.all
      f.input :expected_rate, input_html: {:style => 'width:28.5%'}
      f.input :for_free_plan, as: :boolean
    end
    f.actions
  end

  show do
    attributes_table do
      row :company
      row :expected_rate
      row :for_free_plan
      row :created_at
    end
  end

end
