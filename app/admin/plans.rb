ActiveAdmin.register Plan do
  permit_params :name, :currency, :interval, :interval_count, :amount, :stripe_plan_id, :stripe_product_id

  controller do
    def create
      stripe_product = Stripe::Product.create({name: params[:plan][:name], type: 'service'})
      stripe_plan = Stripe::Plan.create({
        amount: params[:plan][:amount].to_i,
        currency: params[:plan][:currency],
        interval: params[:plan][:interval],
        product: stripe_product.id,
        interval_count: params[:plan][:interval_count],
        nickname: params[:plan][:name],
      })
      params[:plan][:stripe_plan_id] =  stripe_plan.id
      params[:plan][:stripe_product_id] =  stripe_product.id   
      create! 
    end
    # def update
    #   plan = Plan.find(params[:id])
    #   Stripe::Plan.update(
    #     plan.stripe_plan_id,
    #     :amount =>  params[:plan][:amount].to_i,
    #     :interval =>  params[:plan][:interval],
    #     :interval_count =>  params[:plan][:interval_count],
    #     :name =>  params[:plan][:name],
    #     :currency => params[:plan][:currency],
    #   )
    #   update!
    # end
    def destroy
      plan = Plan.find(params[:id])
      #Stripe::Plan.delete(plan.stripe_plan_id)
      destroy!
    end
  end 
  
  index do
     selectable_column
     id_column
      column :name
      column "Duration", :interval do |plan|
        "#{plan.interval_count} #{plan.interval}"
      end
      column :amount do |plan|
        "$ #{plan.amount}"
      end
      column :currency
      column :stripe_plan_id
      column :created_at
    actions
  end

  filter :name
  filter :interval, as: :searchable_select, :collection => Plan.intervals, label: "Duration"
  filter :amount
  filter :currency
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name, as: :searchable_select, :collection => ["free", "premimum"]
      f.input :interval_count, :label => "Duration", input_html: {:style => 'width:28.5%'} 
      f.input :interval, :label => "Duration Type", as: :searchable_select
      f.input :currency, input_html: {:style => 'width:28.5%'} 
      f.input :amount, input_html: {:style => 'width:28.5%'}  
      f.input :stripe_plan_id, :as => :hidden
      f.input :stripe_product_id, :as => :hidden
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row "Duration", :interval do |plan|
        "#{plan.interval_count} #{plan.interval}"
      end
      row :amount do |plan|
        "$ #{plan.amount}"
      end
      row :currency
      row :stripe_plan_id
    end
  end
  
end
