ActiveAdmin.register UserAnalyzedTrade do
  menu parent: "User"
  actions :all, :except => [:new,:edit]
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :today_trade_id, :company_rate, :user_id, :gain_or_loss, :company_expected_rate
  #
  # or
  #
  # permit_params do
  #   permitted = [:today_trade_id, :current_rate, :user_id, :gain_or_loss]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
