ActiveAdmin.register UserAnalyzedTrade do
  menu parent: "User"
  actions :all, :except => [:new,:edit]
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :analyzed_rate, :user_id, :gain_or_loss, :analyzed_expected_rat
  #
  # or
  #
  # permit_params do
  #   permitted = [:today_trade_id, :current_rate, :user_id, :gain_or_loss]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
   index do
    selectable_column
    id_column
    column :company_id do |tt|
      tt.company.name
    end
    column :user_id do |tt|
      tt.user.email
    end
    column :analyzed_rate
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :company_id do |tt|
        tt.company.name
      end
      row :user_id do |tt|
        tt.user.email
      end
      row :analyzed_rate
      row :created_at
    end
  end
  
end
