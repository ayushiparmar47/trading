ActiveAdmin.register Plan do
  menu parent: "Plan"
  permit_params :name, :currency, :interval, :interval_count, :amount, :stripe_plan_id, :stripe_product_id, :trial_day, :country
  actions :all, :except => [:edit]
  
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
    
    def destroy
      plan = Plan.find(params[:id])
      Stripe::Plan.delete(plan.stripe_plan_id)
      destroy!
    end
  end 

  member_action :get_currency_code, method: :get do
    country_code = params[:id]
    currency = ISO3166::Country[country_code]
    @currency_code = currency&.currency_code 
    render json: @currency_code, status: 200
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
      column :trial_day do |plan|
        "#{plan.trial_day} Day's" if plan.trial_day.present?
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
      f.input :name, input_html: {:style => 'width:28.5%'} 
      f.input :interval_count, :label => "Duration", input_html: {:style => 'width:28.5%'} 
      f.input :interval, :label => "Duration Type", as: :searchable_select
      f.input :country, input_html: {:style => 'height: 30px; width: 30%;'} 
      f.input :currency, input_html: {:style => 'width:28.5%', :readonly => true} 
      f.input :amount, input_html: {:style => 'width:28.5%'}  
      f.input :trial_day, input_html: {:style => 'width:28.5%'} 
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
      row :trial_day do |plan|
        "#{plan.trial_day} Day's" if plan.trial_day.present?
      end
      row :currency
      row :stripe_plan_id
      row :created_at
    end
  end
  
end
