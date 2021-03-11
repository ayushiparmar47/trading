require 'finnhub_api'
class Api::V1::CompaniesController < ApplicationController
	before_action :authenticate_api_v1_user!

	# get /api/v1/get_todays_trades
	def get_todays_trades
		if current_api_v1_user.plans.present?
			user_plans = current_api_v1_user.plans.pluck(:name)
			@trades = TodayTrade.all.select{|tt| tt.plans.include? user_plans.first}
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

		# Commented FOR EXPECTED RATE
		# trades.select { |t| symbols << [t.company.symbol,t.expected_rate,t.company.name,t.company.id,t.id]}
		trades.select { |t| symbols << [t.company.symbol,t.company.name,t.company.id,t.id]}
		symbols.each_with_index do |symbol,i|
			current_rate = FinnhubApi::fetch_company_rate symbol[0]
			company_details = FinnhubApi::fetch_company_profile symbol[0]
			# TODO uncomment this once paid api done
			# company_history_rate = FinnhubApi::fetch_company_history_rates symbol[0]
			# Commented FOR EXPECTED RATE
			# expected_rate = symbol[1]
			# difference , percenage_difference = fetch_gap expected_rate, current_rate
			
			# TODO uncomment this once paid api done
			# data = {logo: company_details["logo"],comapany_name: symbol[1],symbol: symbol[0],gap_in_percent: percenage_difference,gap: difference,current_rate: current_rate,expected_rate: symbol[1],company_profile: { company_details: company_details, company_id: symbol[3], trade_id: symbol[4], company_history_rate: company_history_rate}}
			# Commented FOR EXPECTED RATE
			# data = {logo: company_details["logo"],comapany_name: symbol[1],symbol: symbol[0],gap_in_percent: percenage_difference,gap: difference,current_rate: current_rate,expected_rate: symbol[1],company_profile: { company_details: company_details, company_id: symbol[3], trade_id: symbol[4]}}
			data = {logo: company_details["logo"],comapany_name: symbol[1],symbol: symbol[0],current_rate: current_rate,company_profile: { company_details: company_details, company_id: symbol[2], trade_id: symbol[3]}}
			# data_hash["trade_data_#{i+1}"] = data
			data_array << data 
		end
			# data_array << data_hash
		return data_array
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
