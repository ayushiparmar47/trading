ActiveAdmin.register Company do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :symbol, :name, :expected_rate
  #
  # or
  #
  # permit_params do
  #   permitted = [:symbol, :name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  # batch_action :flag do |ids|
  #   batch_action_collection.find(ids).each do |post|
  #   end
  #   # redirect_to api_v1_companies_path, alert: "The posts have been flagged."
  # end 
  
end
