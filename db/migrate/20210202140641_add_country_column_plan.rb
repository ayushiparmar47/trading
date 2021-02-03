class AddCountryColumnPlan < ActiveRecord::Migration[5.2]
  def change
  	add_column :plans, :country, :string
  end
end
