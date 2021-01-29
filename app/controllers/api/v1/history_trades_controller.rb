class Api::V1::HistoryTradesController < ApplicationController
	before_action :authenticate_api_v1_user!

	def index
		histroy_trades = HistoryTrade.all
		if histroy_trades.present? 
			render_collection(histroy_trades, 'histroy_trades', HistoryTrade, "History of trades...!")
		else
			render_error("Not avalable any history of trades...!")
		end
	end

end
