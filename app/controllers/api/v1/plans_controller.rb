class Api::V1::PlansController < ApplicationController
	
	before_action :authenticate_api_v1_user!

	def index
		@plans = Plan.all
		render json: {success: true, plan: @plans, massage: "Plan list"}
	end

end
