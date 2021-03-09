require 'active_record'
# require 'fileutils'
require 'finnhub_api'

desc "This task will fetch the company name and symbol"
	task :get_companies_details => :environment do
		# Rails.logger.info "company details"
		puts "Company Details"
		response = FinnhubApi::get_companies_symbols
		response.each do |res|
			# Rails.logger.info "---- #{res} ----"
			com_name = res["description"]
			# Rails.logger.info "-- #{com_name} --"
			puts " Company = #{com_name} "
			symbol = res["symbol"]
			puts " Symbol = #{symbol} "
			# Rails.logger.info "=== #{symbol} ==="
			Company.create(name: com_name , symbol: symbol)
		end
	end

desc "Task for fetching comapany name and symbols every 24 hrs"
	task :fetch_company_details_every_24_hrs => :environment do
		# Rails.logger.info "Trends Details"
		puts "Company Details"
		response = FinnhubApi::get_companies_symbols
	 	# Rails.logger.info "***** #{response} *****"
		response.each do |res|
			# Rails.logger.info "---- #{res} ----"
			com_name = res["description"]
			# Rails.logger.info "-- #{com_name} --"
			puts " Company = #{com_name} "
			symbol = res["symbol"]
			# Rails.logger.info "=== #{symbol} ==="
			puts " Symbol = #{symbol} "
			Company.find_or_create_by(name: com_name , symbol: symbol)
		end
	end
