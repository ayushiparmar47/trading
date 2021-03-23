require 'finnhub_api'
class Api::V1::CompaniesController < ApplicationController
	before_action :authenticate_api_v1_user!

	# get /api/v1/get_todays_trades
	def get_todays_trades
		if current_api_v1_user.plans.present?
			user_plans = current_api_v1_user.plans.pluck(:name)
			@trades = current_api_v1_user.plans.first.today_trades
			# @trades = TodayTrade.all.select{|tt| tt.plans.include? user_plans.first}
			@today_trades = fetch_trades @trades
			render json: {success: true, message: "Today's Trade", data: @today_trades.as_json}, status: 200
		else
			render json: {success: false, message: "Please Subscribe to our plans"}
		end		
	end

	# Fetch the trades for the selected companies
	def fetch_trades trades
		symbols = []
		data_array = []
		data_hash = {}
		trades.select { |t| symbols << [t.company.symbol,t.company.name,t.company.id,t.id]}
		symbols.each_with_index do |symbol,i|
			current_rate = FinnhubApi::fetch_company_rate symbol[0]
			company_details = FinnhubApi::fetch_company_profile symbol[0]
			data = {logo: company_details["logo"],comapany_name: symbol[1],symbol: symbol[0],current_rate: current_rate,company_profile: { company_details: company_details, company_id: symbol[2], trade_id: symbol[3]}}
			data_array << data 
		end
		return data_array
	end
end
