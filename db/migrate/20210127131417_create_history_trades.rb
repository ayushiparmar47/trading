class CreateHistoryTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :history_trades do |t|
    	t.string  :company_name
    	t.string :symbol
    	t.float :expected_rate
      t.timestamps
    end
  end
end
