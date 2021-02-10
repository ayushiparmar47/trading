class Payment < ApplicationRecord
	belongs_to :user
  enum status: %i[succeeded failed pending]
end
