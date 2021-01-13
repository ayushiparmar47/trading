ActiveAdmin.register TodayTrade do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :company_id, :for_free_plan, :expected_rate
  #
  # or
  #
  # permit_params do
  #   permitted = [:company_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
  f.inputs do
    f.input :company_id, as: :searchable_select, input_html: {:style => 'width:28.5%'}, :collection => Company.all
    f.input :expected_rate, input_html: {:style => 'width:28.5%'}
    f.input :for_free_plan, as: :boolean
  end
  f.actions
end
end
