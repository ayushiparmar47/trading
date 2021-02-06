class Company < ApplicationRecord
	has_many :user_analyzed_trades, dependent: :destroy
end
