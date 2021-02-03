ActiveAdmin.register HistoryTrade do
	menu parent: "Trade"

  action_item :clear_all, if: proc { action_name == 'index' && HistoryTrade.all.present? } do
    link_to 'Clear All', action: 'clear_all'
  end

  collection_action :clear_all do
    HistoryTrade.destroy_all
    flash[:notice] = ('History of Trade clear successesfull.')
    redirect_to  admin_history_trades_path
  end

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
