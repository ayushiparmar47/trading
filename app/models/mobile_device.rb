class MobileDevice < ApplicationRecord
	belongs_to :user
  enum device_type: { web: 2, android: 1, ios: 0 }
end
