class Api::V1::SubscriptionsController < ApplicationController
	before_action :authenticate_api_v1_user!

	def create
		@data = []
		user = current_api_v1_user
		@subscription = user.subscriptions.new(subscription_params)
		@plan = Plan.find(params[:subscription][:plan_id])
		if user.subscribed?
      @data.push(success: false, message: 'Unable to create subscription, user already subscribed')
    elsif @plan.amount == 0.0
    	if @subscription.save
	    	user.update(subscribed: true)
		    @data.push(success: true, subscription: @subscription, massage: "Plan subscription done !", subscription_state: true)
		  else
		    @data.push(success: false, message: @subscription.errors.full_messages)
		  end
    else
		  token = params[:subscription][:stripeToken]
		  if token.present?
		  	type = params[:subscription][:type]
		  	stripe = StripeBaseClass.new(token, user, type, @plan.id)
		  	charge = stripe.charge
		  	if charge.paid? && charge.status == "succeeded"
		  		payment = user.payments.create(amount: params[:subscription][:amount], stripe_charge_id: charge.id, payment_source: params[:subscription][:type], status: "succeeded")
		  		stripe_subscription = stripe.create_subscription
		  		@subscription.stripe_charge_id = charge.id
		  		if @subscription.save
			    	user.update(subscribed: true)
				    @data.push(success: true, subscription: @subscription, massage: "Plan subscription done !", subscription_state: true)
				  else
				    @data.push(success: false, message: @subscription.errors.full_messages)
				  end
				else
					@data.push(success: false, message: "Pay amount #{charge.status}")
				end  
			end
  	end
		rescue StandardError => e
    @data.push(success: false, message: e.message)
    ensure
    render json: @data.first
	end

	def unsubscribed
		@data = []
		user = current_api_v1_user
		subscription = Subscription.find(params[:id])
		plan = subscription.plan if subscription.present?
		if user.present?
			if Time.now < subscription.trial_date
				if subscription.destroy
					user.update(subscribed: false)
					PayAmount.create(user_id: user.id, amount: plan.amount, payment_type: "refund", status: 0)
					@data.push(success: true, massage: "Plan unsubscribed...!",subscription_state: false)
				else
					@data.push(success: false, message: subscription.errors.full_messages.to_sentence)
				end
			else
				@data.push(success: false, message: "You can't unsubscribed this packege. You have been cross limit of free trial...!")
			end		
		else
			@data.push(success: false, message: "Sign in first")
		end
		rescue StandardError => e
    @data.push(success: false, message: e.message)
    ensure
    render json: @data.first
	end

	protected

  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :stripe_customer_id, :stripe_subscription_id, :stripe_payment_id) 
  end

end
