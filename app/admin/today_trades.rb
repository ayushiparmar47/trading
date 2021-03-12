ActiveAdmin.register TodayTrade do
	menu parent: "Trade"
  permit_params :company_id, plans: []

 index do
    selectable_column
    id_column
    column :company_id do |tt|
      tt.company.name
    end
    column :plans
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :company_id, as: :searchable_select, input_html: {:style => 'width:28.5%'}, :collection => Company.all
      f.input :plans, as: :searchable_select, :collection => Plan.all.pluck(:name), multiple: true,input_html: {:style => 'width:20%'}
    end
    f.actions
  end
  show do
    attributes_table do
      row :company_id do |tt|
        tt.company.name
      end
      row :plans
    end
  end
end
