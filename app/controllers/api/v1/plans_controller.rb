class Api::V1::PlansController < ApplicationController
	
	#before_action :authenticate_api_v1_user!

	def index
		@plans = Plan.all
		#receiver_ids = current_api_v1_user.id
		if @plans.present? 
			render_collection(@plans, 'plan', Plan, "Plan list...!")
			# PushNotification.trigger_notification(receiver_ids,'plan_list', @plans) 
		else
			render_error("Not avalable any plans...!")
		end
	end

end
