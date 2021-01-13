class RemoveCurrentRateFromUserAnalyzedTrade < ActiveRecord::Migration[5.2]
  def change
  	remove_column :user_analyzed_trades, :current_rate
  end
end
