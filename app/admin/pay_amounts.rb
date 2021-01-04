ActiveAdmin.register PayAmount do
	actions :all, :except => [:new, :edit, :destroy, :show]

	member_action :pay, method: :post do
		unless resource.payed?
			user = resource.user
			totel_amount = user&.wallet&.totel_amount + resource.amount
			user&.wallet.update_attributes(totel_amount: totel_amount)
			resource.update(status: 1, payed: true)
			flash[:notice] = ('Pay amount to user successesfull.')
		else
			flash[:error] = ('Amount already paid to user')
		end 
	  redirect_to admin_pay_amounts_path
  end

  member_action :delete, method: :delete do
    resource.destroy
    flash[:notice] = ('Pay amount destroy successesfull.')
    redirect_to admin_pay_amounts_path
  end

	index do
    selectable_column
    id_column
    column "Image" do |pay_amount|
      if pay_amount.user.image.present?
        image_path = "#{pay_amount.user.image_url}"
      else
        image_path = ActionController::Base.helpers.image_url("blanck_user.png")
      end
      image_tag image_path 
    end
    column :first_name do |pay_amount|
    	pay_amount.user.first_name
    end
    column :email do |pay_amount|
    	pay_amount.user.email
    end
    column :amount
    column :payment_type
    column :status
    column :payed
    actions defaults: true do |pay_amount|
      link_to "Pay", pay_admin_pay_amount_path(pay_amount.id), method: :post unless pay_amount.payed?
      link_to "Delete", delete_admin_pay_amount_path(pay_amount.id), method: :delete, data: {confirm: "Are you sure you want to delete this?"} if pay_amount.payed?
    end
  end

end