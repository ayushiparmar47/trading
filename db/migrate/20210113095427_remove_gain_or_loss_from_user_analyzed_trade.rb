class RemoveGainOrLossFromUserAnalyzedTrade < ActiveRecord::Migration[5.2]
  def change
  	remove_column :user_analyzed_trades, :gain_or_loss
  end
end
