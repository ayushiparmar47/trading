class Api::V1::PlansController < ApplicationController
	before_action :authenticate_api_v1_user!

	def index
		@plans = Plan.all
		render json: {success: true, plan: @plans, massage: "Plan list"}
	end

	def pick_plan
	  @subscription = PlanSubscription.new(plan_subscription_params)
	  if @subscription.save_with_payment
	    redirect_to @subscription, :notice => "Thank you for subscribing!"
	  else
	    render :new
	  end
	end

	protected

  def plan_subscription_params
    params.require(:plan_subscription).permit(:email,:password,:first_name, :image) 
  end
	
end
