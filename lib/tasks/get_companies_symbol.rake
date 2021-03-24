require 'active_record'
# require 'fileutils'
require 'finnhub_api'

desc "This task will fetch the company name and symbol"
	task :get_companies_details => :environment do
		Rails.logger.info "company details"
		response = FinnhubApi::get_companies_symbols
		 Rails.logger.info "***** #{response} *****"
		response.each do |res|
			# Rails.logger.info "---- #{res} ----"
			com_name = res["description"]
			Rails.logger.info "-- #{com_name} --"
			symbol = res["symbol"]
			Rails.logger.info "=== #{symbol} ==="
			Company.find_or_create_by(name: com_name , symbol: symbol)
		end
	end
