class AddPlansToHistroyTrade < ActiveRecord::Migration[5.2]
  def change
    add_column :history_trades, :plans, :string, array: true, default: []
  end
end
