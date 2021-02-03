ActiveAdmin.register DiscountCode do

  permit_params :codes, :discount, :plan_id, :start_date, :end_date, :active, user_id: []

  controller do
  	def create
  		params[:discount_code][:user_id] = params[:discount_code][:user_id].drop(1)
  		create! 
  	end

  	def update
  		params[:discount_code][:user_id] = params[:discount_code][:user_id].drop(1)
  		update! 
  	end
  end
  
  index do
    selectable_column
    id_column
    column :codes
    column :discount do |discount_code|
    	"#{discount_code.discount} %"
    end
    column :plan
    column :start_date
    column :end_date
    column :active
    column :created_at
    actions
  end

  filter :codes
  filter :discount
  filter :plan, as: :searchable_select
  filter :active, as: :boolean
  filter :start_date
  filter :end_date
  filter :created_at

  form do |f|
    f.inputs do
      f.input :codes
      f.input :discount
      f.input :plan, as: :searchable_select
      f.input :user_id, as: :searchable_select, :multiple => true, :collection => User.all.map{|user| [user.first_name, user.id]}
   		f.input :start_date, as: :date_time_picker, datepicker_options: { min_date: Time.now}
   		f.input :end_date, as: :date_time_picker, datepicker_options: { min_date: Time.now}
   		f.input :active, as: :boolean
    end
    f.actions
  end

  show do
    attributes_table do
      row :codes
      row :discount do |discount_code|
      	"#{discount_code.discount} %"
      end
      row :plan
      row :start_date
      row :end_date
      row :active
      row :user_id do |discount_code|
      	discount_code.user_id.map { |id| [User.find(id)&.first_name] }
      end
      row :created_at
    end
  end

end