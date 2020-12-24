require 'finnhub_api'
class Api::V1::CompaniesController < ApplicationController
	before_action :authenticate_api_v1_user!


	# get /api/v1/get_todays_trades
	def get_todays_trades
		if current_api_v1_user.present?
			# trade_data = fetch_trades

		# if current_api_v1_user.plan == "free"
			# @trades = TodayTrade.where(for_free_plan: true)
			# @free_trades = fetch_trades @trades
			# if @free_trades.present?
			# 	render json: {success: true, data: @free_trades.as_json}, status: 200
			# else
			# 	render json: {success: false, message: "No trades suggestion is present"}
			# end
		# else
		# RIGHT NOW ALL TRADES WILL BE SHOWN
			@p_trades = TodayTrade.all
			@paid_trades = fetch_trades @p_trades
			if @paid_trades.present?
				render json: {success: true, data: @paid_trades.as_json}, status: 200
			else
				render json: {success: false, message: "No trades suggestion is present"}
			end
		# end
		else
			render json: {success: false, message: "Please Sign in first.."}
		end
	end

	# Fetch the trades for the selected companies
	def fetch_trades trades
		symbols = []
		data_hash = {}
		trades.select { |t| symbols << [t.company.symbol,t.company.expected_rate,t.company.name,t.company.id,t.id]}
		symbols.each_with_index do |symbol,i|
			current_rate = FinnhubApi::fetch_company_rate symbol[0]
			company_details = FinnhubApi::fetch_company_profile symbol[0]
			company_history_rate = FinnhubApi::fetch_company_history_rates symbol[0]
			expected_rate = symbol[1]
			difference , percenage_difference = fetch_gap expected_rate, current_rate
			data = {logo: company_details["logo"],comapany_name: symbol[2],symbol: symbol[0],gap_in_percent: percenage_difference,gap: difference,current_rate: current_rate,expected_rate: symbol[1],company_profile: { company_details: company_details, company_id: symbol[3], trade_id: symbol[4], company_history_rate: company_history_rate}}
			data_hash["trade_data_#{i+1}"] = data 
		end
		return data_hash
	end

	# Calculate the difference and percenage difference
	def fetch_gap expected_rate, current_rate
		# 100 * |a - b| / ((a + b) / 2)
		difference = (expected_rate - current_rate).abs
		average = (expected_rate + current_rate) / 2
		percenage_difference = (difference*100 / average)
		return difference.round(2) , percenage_difference.round(2)
	end

end
