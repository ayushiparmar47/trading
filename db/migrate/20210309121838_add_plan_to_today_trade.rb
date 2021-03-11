class AddPlanToTodayTrade < ActiveRecord::Migration[5.2]
  def change
    add_column :today_trades, :plans, :string, array: true, default: []
  end
end
