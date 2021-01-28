ActiveAdmin.register HistoryTrade do
	menu parent: "Trade"

	index do
    selectable_column
    id_column
    column :company_name
    column :symbol
    column :created_at
    actions
  end

  filter :company_name
  filter :symbol
  filter :created_at

  show do
    attributes_table do
      row :company_name
      row :symbol
      row :created_at
    end
  end

end
