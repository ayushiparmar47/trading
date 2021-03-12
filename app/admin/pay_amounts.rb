ActiveAdmin.register PayAmount do

	member_action :pay, method: :post do
		user = resource.user
    bonus = user.bonus.build(amount: resource.amount)
    if bonus.save
  		resource.update(status: 1, payed: true)
  		flash[:notice] = ('pay amount has succeeded.') 
    else
      flash[:error] = ('pay amount has failed. Please try again later')
    end
	  redirect_to admin_pay_amounts_path
  end

	index do
    selectable_column
    id_column
    column "Image" do |pay_amount|
      if pay_amount.user.image.present?
        image_path = "#{pay_amount.user.image_url}"
      else
        image_path = ActionController::Base.helpers.image_url("user.jpeg")
      end
      image_tag image_path 
    end
    column :first_name do |pay_amount|
    	pay_amount.user.first_name
    end
    column :email do |pay_amount|
    	pay_amount.user.email
    end
    column :amount do |pay_amount|
      pay_amount.amount.round(2)
    end
    column :payment_type
    column :status
    column :payed
    column "Payed At", :created_at do |pay_amount|
        pay_amount.created_at
      end
    actions defaults: true do |pay_amount|
      unless pay_amount.payed?
        link_to "Pay", pay_admin_pay_amount_path(pay_amount.id), method: :post
      end
    end
  end

  filter :amount
  filter :payment_type
  filter :status
  filter :created_at, label: "Payed At"

  show do
    attributes_table do
      row "Image" do |pay_amount|
        if pay_amount.user.image.present?
          image_path = "#{pay_amount.user.image_url}"
        else
          image_path = ActionController::Base.helpers.image_url("user.jpeg")
        end
        image_tag image_path 
      end
      row :first_name do |pay_amount|
        pay_amount.user.first_name
      end
      row :email do |pay_amount|
        pay_amount.user.email
      end
      row :amount do |pay_amount|
        pay_amount.amount.round(2)
      end
      row :payment_type
      row :status
      row :payed
      row "payed at", :created_at do |pay_amount|
        pay_amount.created_at
      end
    end
  end

end