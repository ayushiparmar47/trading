ActiveAdmin.register Company do

  menu parent: "Trade"
  permit_params :symbol, :name
  
  index do
    selectable_column
    id_column
    column :symbol
    column :name
    column :created_at
    actions
  end

  filter :symbol
  filter :name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :symbol
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :symbol
      row :name
      row :created_at
    end
  end
  
end
