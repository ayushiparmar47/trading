class Api::V1::SubscriptionsController < ApplicationController
	before_action :authenticate_api_v1_user!

	def create
		@subscription = Subscription.new(subscription_params)
		@data = []
		token = Stripe::Token.create({
	  card: {
	    number: params['card_number'],
	    exp_month: params['exp_month'],
	    exp_year: params['exp_year'],
	    cvc: params['cvc'],
	    },
	  })
	  if token.present?
		  user = current_api_v1_user
		  plan_id = params[:subscription][:plan_id]
		  stripe_card_token = token.id
  		@subscription.save_with_payment(user, plan_id, stripe_card_token)
  		if @subscription.save
	  		#@plan_subscription = PlanSubscription.create(user_id: user.id, plan_id: plan_id)
	    	user.update(subscribed: true)
		    @data.push(success: true, subscription: @subscription, massage: "Plan subscription done !")
		  else
		    @data.push(success: false, message: @subscription.errors.full_messages)
		  end
		end
		rescue StandardError => e
    @data.push(success: false, message: e.message)
    ensure
    render json: @data.first
	end

	protected

  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :stripe_customer_id, :stripe_subscription_id) 
  end

end
