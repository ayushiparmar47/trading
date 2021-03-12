class TodayTrade < ApplicationRecord
  belongs_to :company

  after_create :add_history

  before_save do |model|
    model.plans.reject!(&:blank?)
  end

  def add_history
  	HistoryTrade.create(company_name: self.company&.name, symbol: self.company&.symbol, plans: self.plans)
  end

end
