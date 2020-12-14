class AddRateToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :expected_rate, :float
    
  end
end
