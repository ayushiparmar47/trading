class RemoveExpectedRateFromCompany < ActiveRecord::Migration[5.2]
  def change
  	remove_column :companies, :expected_rate
  end
end
