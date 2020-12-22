class CreateUserAnalyzedTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :user_analyzed_trades do |t|
    	t.references :today_trade, foreign_key: true
      t.float :current_rate
      t.references :user, foreign_key: true
      t.float :gain_or_loss
      t.timestamps
    end
  end
end
