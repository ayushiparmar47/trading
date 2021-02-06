class UserAnalyzedTrade < ApplicationRecord
	# belongs_to :today_trade
	belongs_to :user
	belongs_to :company
end
