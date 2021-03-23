class CreateTradePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :trade_plans do |t|
      t.references :plan
      t.references :today_trade

      t.timestamps
    end
  end
end
