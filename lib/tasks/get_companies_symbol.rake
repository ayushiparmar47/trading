# require 'active_record'
# require 'fileutils'
# require 'finnhub_api'

# desc "This task will fetch the company name and symbol"
# 	task :get_companies_details => :environment do
# 	Rails.logger.info "company details"
# 	response = FinnhubApi::get_companies_symbols
# 	 Rails.logger.info "***** #{response} *****"
# 	response.each do |res|
# 		# Rails.logger.info "---- #{res} ----"
# 		com_name = res["description"]
# 		Rails.logger.info "-- #{com_name} --"
# 		symbol = res["symbol"]
# 		Rails.logger.info "=== #{symbol} ==="
# 		Company.create(name: com_name , symbol: symbol)
# 	end
# end

# desc "Task description"
# task :fetch_trades_details => :environment do
# 	Rails.logger.info "Trends Details"
# 	symbols = []
# 	TodayTrade.all.select { |t| symbols << t.company.symbol}
# 	symbols.each do |symbol|
# 		FinnhubApi::fetch_company_rate symbol
# 	end
# 	# Rails.logger.info "--#{symbols}--"
# end
