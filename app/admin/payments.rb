ActiveAdmin.register Payment do

  permit_params :amount, :user, :stripe_charge_id, :status, :payment_source, :refunded
  
  index do
    selectable_column
    id_column
    column :amount
    column :user
    column :status
    column :payment_source
    column :refunded
    column :created_at
    actions defaults: true do |payment|
      unless payment.refunded?
        link_to "Refund", refund_admin_payment_path(payment.id), method: :post
      end
    end 
  end

  filter :amount
  filter :status
  filter :payment_source
  filter :created_at

  show do
    attributes_table do
      row :amount
      row :user
      row :status
      row :payment_source
      row :refunded
      row :created_at
    end
  end

  member_action :refund, method: :post do
    @data = []
    payment = resource
    refund = Stripe::Refund.create({ charge: payment.stripe_charge_id })
    if refund.status == "succeeded"
      payment.update(refunded: true)
      @data.push(notice: 'Payment Refund successesfull.')
    end
    rescue Stripe::InvalidRequestError => e
    @data.push(error: e.message)
    ensure
    message = @data.first
    if message.keys[0] == :error
      flash[:error] = message.values[0]
    else
      flash[:notice] = message.values[0]
    end
    redirect_to admin_payments_path
  end
 
end
