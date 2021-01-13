class AddCompanyRateAndCompanyExpectedRateToUserAnalyzedTrade < ActiveRecord::Migration[5.2]
  def change
    add_column :user_analyzed_trades, :company_rate, :float
    add_column :user_analyzed_trades, :company_expected_rate, :float
  end
end
