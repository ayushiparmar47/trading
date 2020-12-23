class Api::V1::PlansController < ApplicationController
	
	before_action :authenticate_api_v1_user!

	def index
		@plans = Plan.all
		if @plans.present?
			render_collection(@plans, 'plan', Plan, "Plan list...!")
		else
			render_error("Not avalable any plans...!")
		end
	end

end
