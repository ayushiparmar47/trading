class AddCompanyIdToUserAnalyzedTrades < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_analyzed_trades, :company, foreign_key: true
    remove_column :user_analyzed_trades, :today_trade_id
  end
end
