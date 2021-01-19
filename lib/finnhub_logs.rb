module FinnhubLogs

	class Logger
		LOGGER = ::Logger.new("log/finnhub.log")

		LOGGER.formatter = proc { |severity, datetime, progname, msg|
                      "#{severity}:#{datetime} => #{msg}\n"
                     }

    def self.info info
#      p "#{info}"
      Rails.logger.info info
      LOGGER.info info 
    end

    def self.error error
      p "#{error}"
      Rails.logger.error error
      LOGGER.error error
    end
    
	end
end
