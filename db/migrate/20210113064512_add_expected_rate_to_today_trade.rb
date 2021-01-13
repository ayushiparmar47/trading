class AddExpectedRateToTodayTrade < ActiveRecord::Migration[5.2]
  def change
    add_column :today_trades, :expected_rate, :float
  end
end
