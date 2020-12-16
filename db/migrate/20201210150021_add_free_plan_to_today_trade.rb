class AddFreePlanToTodayTrade < ActiveRecord::Migration[5.2]
  def change
    add_column :today_trades, :for_free_plan, :boolean
  end
end
