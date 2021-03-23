class TradePlan < ApplicationRecord
  belongs_to :today_trade
  belongs_to :plan
  # accepts_nested_attributes_for :plan
end
