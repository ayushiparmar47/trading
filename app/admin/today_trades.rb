 ActiveAdmin.register TodayTrade do
	menu parent: "Trade"
  permit_params :company_id, plans: []

  controller do
    def create
      today_trade = TodayTrade.new(today_trade_params)
      if today_trade.save
        redirect_to admin_today_trades_path
      else
        render new
      end
    end

    def update
      today_trade = TodayTrade.find_by(id: params[:id])
      if today_trade.update(today_trade_params)
        redirect_to admin_today_trades_path
      else
        render edit
      end
    end

    def today_trade_params
      params.require(:today_trade).permit(:company_id, plan_ids: [])
    end
  end

  index do
    selectable_column
    id_column
    column :company_id do |tt|
      tt.company.name
    end
    column :plans do |tt|
      tt.plans.pluck(:name)
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :company_id, as: :searchable_select, input_html: {:style => 'width:28.5%'}, :collection => Company.all
      f.input :plan_ids, as: :searchable_select, :collection => Plan.all, multiple: true,include_blank: true,input_html: {:style => 'width:20%'}
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
