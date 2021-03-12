class Api::V1::BonusController < ApplicationController
	before_action :authenticate_api_v1_user!

	def index
		@totel = 0.0
		@bonus = current_api_v1_user.bonus.where(collected: false)
		if @bonus.present?
			@bonus.each do |bonus|
			  @totel = @totel + bonus.amount
			end
			render_collection(@bonus, 'bonus', Bonu, "User Bonus ...!", totel: @totel)
		else
			render_error("Not avalable any bonus...!")
		end
	end

	def collect_bonus
		@totel = 0.0
		@bonus = current_api_v1_user.bonus.where(collected: false)
		@bonus.each do |bonus|
			@totel = @totel + bonus.amount
		end
		wallet_amount = current_api_v1_user.wallet&.totel_amount + @totel
  	if current_api_v1_user.wallet.update_attributes(totel_amount: wallet_amount)
  		@bonus.update_all(collected: true)
  		render json: { success: true, message: "pay amount has been added in your wallet"}
  	else
  		render_error("pay amount has been failed. Please try again later")
  	end
	end

end
