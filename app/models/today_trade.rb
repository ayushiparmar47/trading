class TodayTrade < ApplicationRecord
  belongs_to :company

  after_create :add_history

  def add_history
  	HistoryTrade.create(company_name: self.company&.name, symbol: self.company&.symbol)
  end

end
