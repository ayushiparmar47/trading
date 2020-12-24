require 'net/http'

module FinnhubApi
	  VERB_MAP = {
    :get    => Net::HTTP::Get,
    :post   => Net::HTTP::Post,
    :put    => Net::HTTP::Put,
    :delete => Net::HTTP::Delete   
  }.with_indifferent_access

  class << self
  	def get_companies_symbols
  		api_token = APP_CONFIG["api_key"]
  		res = request :get, "https://finnhub.io/api/v1/stock/symbol?exchange=US&token=#{api_token}"
  	end

  	def fetch_company_rate symbol
      api_token = APP_CONFIG["api_key"]
  		res = request :get, "https://finnhub.io/api/v1/quote?symbol=#{symbol}&token=#{api_token}"
  		current_rate = res["c"]
  		return current_rate
  	end

    def fetch_company_history_rates symbol
      token = APP_CONFIG["iexcloud_token"]
      response = request :get, "https://cloud.iexapis.com/stable/stock/#{symbol}/chart/6m?token=#{token}"
      historical_prices = fetch_datewise_record response
    end

    def fetch_datewise_record res
      historical_prices = {}
      res.each_with_index do |data,i|
          historical_prices["#{data["date"]}"] =  data["close"]
      end
      return historical_prices
    end

    def current_rate_for_dates
     date = []
      cal_date = Date.today
      date << Date.today.to_s
      for i in 0..5
        cal_date = cal_date - 1.months
        date << cal_date.to_s
      end
      return date
  	end

    def fetch_company_profile symbol
  		api_token = APP_CONFIG["api_key"]
  		res = request :get, "https://finnhub.io/api/v1/stock/profile2?symbol=#{symbol}&token=#{api_token}"
  	end

 		def request(verb, uri_str,token = "" , req_type = "", data = {})
	    uri = URI.parse(uri_str)
	    http = Net::HTTP.new(uri.host, uri.port)
	    if uri.scheme=="https"
	      http.use_ssl = true
	      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	    end
	    if req_type.eql? "query_params"
	    	response = http.post(uri.path, data.to_query)
	    elsif req_type.eql? "multi-part"				
				request = Net::HTTP::Post::Multipart.new(uri.path,data)
				response = http.request(request)
	    else
	    	request = VERB_MAP[verb].new(uri.request_uri)
        # request["Content-Type"] = "application/json"
        response = http.request(request)
	    end
	    if ["200", "201"].include? response.code
	      puts "Success  Response Code = #{response.code}, Message = #{response.body}, On API = #{uri_str}"	
	      JSON.parse(response.body) unless response.body == nil
	    else
	      response_body = JSON.parse(response.body) unless response.body == nil
        puts "Failed: Response Code = #{response.code}, Message = #{response_body}, On API = #{uri_str}"
	    	response_body
	    end
		end

  end
end