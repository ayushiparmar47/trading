class Api::V1::UserAnalyzedTradesController < ApplicationController
	before_action :authenticate_api_v1_user!

	def find_user_analyzed_trades
		#date = params[:user_analyzed_trades][:date]
		date = params[:date]
		user_trades = []
		user_analyzed_trades = UserAnalyzedTrade.where("DATE(created_at) = ?", date)
		if user_analyzed_trades.present?
			user_analyzed_trades.each do |uat|
				company_details = FinnhubApi::fetch_company_profile uat.company.symbol
				company =  {logo: company_details["logo"],company_name: company_details["name"] ,company_symbol: uat.company.symbol, user_analyzed_rate: uat.analyzed_rate}
				user_trades << company
			end
			render json: { success: true, user_analyzed: user_trades, message: "User Trades...!"}      
		else
			render json: { success: false, message: "Not analyzed any trades yet!"}
		end
	end

end
