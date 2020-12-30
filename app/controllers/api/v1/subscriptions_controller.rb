class Api::V1::SubscriptionsController < ApplicationController
	before_action :authenticate_api_v1_user!

	def create
		@data = []
		user = current_api_v1_user
		@subscription = user.subscriptions.new(subscription_params)
		if user.subscribed?
      @data.push(success: false, message: 'Unable to create subscription, user already subscribed')
    else
			token = Stripe::Token.create({
		  card: {
		    number: params['card_number'],
		    exp_month: params['exp_month'],
		    exp_year: params['exp_year'],
		    cvc: params['cvc'],
		    },
		  })
		  if token.present?
			  plan_id = params[:subscription][:plan_id]
			  stripe_card_token = token.id
	  		@subscription.save_with_payment(user, plan_id, stripe_card_token)
	  		if @subscription.save
		    	user.update(subscribed: true)
			    @data.push(success: true, subscription: @subscription, massage: "Plan subscription done !")
			  else
			    @data.push(success: false, message: @subscription.errors.full_messages)
			  end
			end
  	end
		rescue StandardError => e
    @data.push(success: false, message: e.message)
    ensure
    render json: @data.first
	end

	def destroy
		@data = []
		user = current_api_v1_user
		if user.present?
			subscription = Subscription.find(params[:id])
			if stripe_subscription_destroy(subscription) && subscription.destroy
				user.update(subscribed: false)
				@data.push(success: true, massage: "Plan unsubscribed...!")
			else
				@data.push(success: false, message: subscription.errors.full_messages.to_sentence)
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

	def stripe_subscription_destroy(subscription)
		Stripe::Subscription.delete(subscription.stripe_subscription_id)
	end

  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :stripe_customer_id, :stripe_subscription_id) 
  end

end