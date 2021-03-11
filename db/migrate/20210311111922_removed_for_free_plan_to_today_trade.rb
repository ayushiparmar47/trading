class RemovedForFreePlanToTodayTrade < ActiveRecord::Migration[5.2]
  def change
    remove_column :today_trades, :for_free_plan
  end
end
