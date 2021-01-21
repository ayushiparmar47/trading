class AddColumnInAdmin < ActiveRecord::Migration[5.2]
  def change
  	add_column :admin_users, :name, :string
  	add_column :admin_users, :phone, :string
  	add_column :admin_users, :image, :string
  	add_column :admin_users, :type, :string
  end
end
