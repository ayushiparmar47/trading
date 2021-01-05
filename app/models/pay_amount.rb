class PayAmount < ApplicationRecord
	belongs_to :user
	
	enum status: { pending: 0, success: 1, cancel: 2 }
end
