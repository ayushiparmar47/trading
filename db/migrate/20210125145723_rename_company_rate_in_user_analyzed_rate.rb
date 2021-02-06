class RenameCompanyRateInUserAnalyzedRate < ActiveRecord::Migration[5.2]
  def change
  	rename_column :user_analyzed_trades, :company_rate, :analyzed_rate
  	rename_column :user_analyzed_trades, :company_expected_rate, :analyzed_expected_rate
  end
end
