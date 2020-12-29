class AddTradingExpToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :trading_exp, :integer
  end
end
