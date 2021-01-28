class Company < ApplicationRecord
	has_many :today_trades, dependent: :destroy
end
