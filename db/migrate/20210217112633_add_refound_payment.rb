class AddRefoundPayment < ActiveRecord::Migration[5.2]
  def change
  	add_column :payments, :refunded, :boolean, :default => false
  end
end
