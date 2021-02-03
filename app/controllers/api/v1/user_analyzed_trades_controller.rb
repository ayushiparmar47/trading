class Api::V1::UserAnalyzedTradesController < ApplicationController
	before_action :authenticate_api_v1_user!

	def find_user_analyzed_trades
		date = params[:user_analyzed_trades][:date]
		user_analyzed_trades = UserAnalyzedTrade.where("DATE(created_at) = ?", date)
		if user_analyzed_trades.present?
			render json: { success: true, user_analyzed: user_analyzed_trades, message: "User Trades...!"}      
		else
			render json: { success: false, message: "Not avalable...!"}
		end
	end

end
